Return-Path: <netdev+bounces-257040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM7PCmJShGkx2gMAu9opvQ
	(envelope-from <netdev+bounces-257040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:18:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A01EFCD9
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F94E300CE77
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93DC360756;
	Thu,  5 Feb 2026 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJPTJ9oj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8255235C182
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.196
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770279503; cv=pass; b=AmOUUqaN2mPPUv7SZWEsFY+si8OjC/azUh7dahFMQ4/eGzltcXAhlOvTsEecBoR/yyDq2LrNiemNv9t/I3AA91C78+I28OvoKC5HOa2HfB3qvsvaq1jRk8iaP/AvhtakyxTIPffGBdMezKJqQkRhH/fFNgiy8QcXYjJyY6yJWhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770279503; c=relaxed/simple;
	bh=dEHmEZtfljzeKDJhyqfkp2NPnFNEfyMYV12kR3/lE68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1ktDM2bwKCT+FdG59Jqjz+IgNoM0xhwzEIj+9R2XJtW9KeYHrbQp2JVHhbcCVyxMrIyMzEfcCH2VdEWsAwS30BNorzfX/z6J7wjatVJdWEBqXQvVD7LWSBmsJeNDow/XTj3qSoenw639/ScfejYNXF3O80koeQEs9f8Ihnj7Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJPTJ9oj; arc=pass smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-50145d27b4cso8040481cf.2
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 00:18:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770279502; cv=none;
        d=google.com; s=arc-20240605;
        b=Ql6Wz6V+BfBO2yUswUAZFMDSI9p4ASDPaIiLjO4cW98Ubdc/RHJqknVy7JlDbweoTx
         rQJxQdGFzZ4PVS5yzW01BjlBdj1t9aEA6uzyUkquUHMagkbceOxWtIqgFqTcTqc5Cz5B
         Y3/lAGJ79G7nCMlkmbxdbIP5p7N9Z0Libv569nZRjkUJe76c8lxdopHbu292PV78juIW
         mqx1gMblQoebubYgALg25SjZj+Kp3/BLUWMC08jWcnZXv49Uu+lAeqtSGKKISGiQk/ET
         yNeTwz1KoUYDvbWbUli+E1bnbA42jouybQ3sFFToGmbeQHdrmsZUrIxdEkw07+BOKR7g
         aoBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dEHmEZtfljzeKDJhyqfkp2NPnFNEfyMYV12kR3/lE68=;
        fh=6r1yaKmaaqDKbk0mz3sX1toFerxBue79AEimE3QZ9VI=;
        b=isMDFoMjrIU/5VnM8AMBn8EN9o5iB21BMYW4SF5Js9f8AtBPe0VqjPGDDKwRR0FIS5
         8ei1AWyWg8u66Jx4Aitt1aGRaegii0QGfFXT6p/uiYbKFcv3l70ZbCiD3nfaWSkXiCAI
         65dayBvBqo95LpZ9UO7bX4VYWHkahqdoSmv8LEpyW+NR69v2S+WWJEum4m+PhJVRaRI3
         FCyQy85PH0r63BaloVXmdnIebEeTj8A1v1JEDl2XpamAxF0+60eyAoAL+OC3vkE6s4jZ
         WU2Ao/1rpAF6Sn0NjNova1+UA3GKBskFx4asrFLOr4NEyyhMNC3cjcVUrBwT1JmXoMRG
         Jx5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770279502; x=1770884302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEHmEZtfljzeKDJhyqfkp2NPnFNEfyMYV12kR3/lE68=;
        b=WJPTJ9ojBzj6DNngLToHBl2X0/oGQkvDV4kjObfvklfHyT6N6h42fRgzVndYvLmvvE
         1rEDuviD0PcCOtMDJRCz/1YrrLSHJYDy0Vg0Q+5bqs002Y2yabAg5l+XRHhBtH6Uv1gk
         yjLtOZRkfMLvk6FV7qMH9Rl1q0kjQPcDZEIFVOTdqduBtrCrxBAjFm6t5FrfEzirSkPC
         Kp96uWeR+YJbgO05CABaas7bqUluLGO9Wc9LQxVs82P+UH+SoUDq4iEK78B+6NdgOnSh
         11J4ueohKbX4T53An8eflVAqPzWb52/3AkBa/1tZeF+Yfcb8Y5Z6P5ONJYwL1lGHWtef
         BKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770279502; x=1770884302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dEHmEZtfljzeKDJhyqfkp2NPnFNEfyMYV12kR3/lE68=;
        b=qq8ASRK/KGXG2DuPqPoqSqbvB/F7W094vPsEfXnaADJq2VQYuuziSQaj8kW3uPOtjL
         erbz0bZ9/yD7KkozYYYClWP+J8zeARZaxU1v65jWoB5P//Sh6f0g78UjcyoN1Z9tcOMS
         NLDddpVPSnjAbocq2Rtvz9EHEpeKi6JSDOXvSyG0vw+hZohIgde6Yxhad45LgTMwGMn/
         5lLoyJcZ/C0j3jDTY440lmNojbMCTTNRYDfp4s8fJS1I4ZoPPfnb8kJZjiO3+Hh6Mwlc
         1Z9N04FTvdZJPqts5REbu9O2jD/HPEQEN9O/10DxqerXXyXmbMow0ediATQ16DSiOcEe
         Rvdg==
X-Gm-Message-State: AOJu0YzDiI4ov/zRl3xIJvLjX3pimVunfI8yMzplsd/EUClwu+HhKrcM
	vplcXZggivGrfADjLfEpKcisMVPN+V0IjtrJXdws0vITHGC/jcFumjqEE7DBfxJnWWKxrPyvCXS
	Nnpmxy/b70bhsDNSx1EGaSwMDRWZbEJ0=
X-Gm-Gg: AZuq6aITpGHRvNrdcjzo/IAY3N4o+vNAYZ5M81uL3c+C/2uRrShF2BXmQqkKRn91/QT
	HI1KrLmuSfWUgk9bpGl1ZEGeHzNA5w9uhU7cmtLdLm0dU0y19iXeG6MS4HmKB+5nO52zjqJqV1S
	lViA8cAkxgSXcEqo0ITJsMxA7ryOxUXCLTPVLtQwMAGahh/Z+yV0MNZ3EsA4W2nOCIdO1F67ErZ
	6vGFQE+zqNJMr3yjDO1UpO8zHeN7UR2sIlV4BFNCdyZkdLxkrPqmwtNRpJO8UXttFN+BLiLO31P
	EpsxwYfRRw/CnLlyrk++DFs4fhW04uzWmg6kWm9IgNa3lOih2hS9PWUwOH6FAcDSojM=
X-Received: by 2002:ac8:5942:0:b0:4ee:275c:28d7 with SMTP id
 d75a77b69052e-5061c1e24dcmr70234931cf.75.1770279502432; Thu, 05 Feb 2026
 00:18:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205075445.43347-1-enelsonmoore@gmail.com> <IA3PR11MB89868B6110780F90795E4ED7E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB89868B6110780F90795E4ED7E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Thu, 5 Feb 2026 00:18:11 -0800
X-Gm-Features: AZwV_Qi279RFUb8dryBzOPG7K4OPVJ4GK9tbcGC43GVruOveblEFmaOLVgoO04w
Message-ID: <CADkSEUiNrMCGzECO2t+Stx7Xnk=bCAp+mk=99FrMZFq4wOmgFQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: intel: fix PCI device ID conflict between
 i40e and ipw2200
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Yakovlev <stas.yakovlev@gmail.com>, Alice Michael <alice.michael@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257040-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,sipsolutions.net,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86A01EFCD9
X-Rspamd-Action: no action

Hi, Alexandr,

On Thu, Feb 5, 2026 at 12:13=E2=80=AFAM Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> wrote:
> Commit message could be more detailed.
> - Why the PCI ID is being reused (if known) Is this actually a reuse afte=
r EOL, or is there a misunderstanding? The commit message hand-waves this c=
ritical detail.
> - Whether this is documented in hardware datasheets
> - If there are bug reports of the conflict in the wild
I don't know any of this information. I found this conflict via a
script I was motivated to write by noticing an ID conflict between
r8169 and 8139too.

> If it's quite critical fix why not to send it to [PATCH net] ?
I used that prefix because the patch is against net-next. It will make
it into stable versions regardless.

Ethan

