Return-Path: <netdev+bounces-286603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI9gLkC0AWr2igEAu9opvQ
	(envelope-from <netdev+bounces-286603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:49:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A80650C31D
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5792C300BBAE
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDACC3DA5BA;
	Mon, 11 May 2026 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQdTmnGg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B13BB9F8
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496571; cv=pass; b=pEP3p4UUl4H0bsfo8Bq1CBX5LAvhwawfXhjY5uTFCI7smSnzVlBGKZeMn2avTX3dMy5mc73S5gpFeBZpkahoUe2edvEKx7O8f8/nxdGJSAyq44elezaB3lp9XVOhqjVFbO4ORmy/5EILR7wTqIeWR1VfdOB1bGuzR0dQhgfKtHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496571; c=relaxed/simple;
	bh=cuJTNQKdn44D+RvMxMg1jFiHwdXukDBhPFom5JXUbCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gop3HwyH5U1lXOJCyGpHZfPoRB1jBCygCXtfdnuG8L3De/0hzQpuRn8YqkW08Tr8owsIG8FhwQbdx0HYvSqN1uCawm77gsifW+aYHyyo4oljIYRC0EwvcguyZDOiP3kXzKfo4ZOTrdZKgniT0dbWavNDnEVIDpSMcg8A65auHLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQdTmnGg; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50faeb8317bso30031851cf.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 03:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778496568; cv=none;
        d=google.com; s=arc-20240605;
        b=UGN7EJhhyPQnFZu+uwBp/luB9I8U3f5niZjkxq2gBaSs2mneQqKgSp+bm4G6CQ1vjY
         e5IxsSH2gMQuEf4YGyeSELdPWvsv8aphfB2ZQwOfJEtk8WSKMtvDT5IgdDJZ7cjcSk2i
         51yFbHY3F0QeT0EAQUNdKUXTW84XM4tOSfi2vxgm6l/1AULmcPFMklrtCttB4bMeOHtV
         8YDn9tCiRFH9XuRV7CFhBHETG5d6Db4bNyNviFN66Dhrxh+VhUeBuo59V2C0K6nn2ed/
         ND45WdVr/gtFahqMaHdGZoJTHzaWb2Rjl/rWOiN5a7it9WASZSJHwmaMkZ2+BBvMaRwS
         aezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cqsy042krG1n2vy+fiyMYLPnlvvdawLZm5elNuTwKzs=;
        fh=rop+SGlvDjJ6GHOJAmo6vGCR3wJXYQ6ZrOexKLITmqI=;
        b=EztQC/ZXVobwap0ikrB7WyGIm2czK+7sGv9qkW33vSvDOSFqHhbKB3vW5V5JPHKDLb
         phDcudAMG+Ei15UfVlvdHfrOlU2H7Xdbj+ATAis9X8keu48tmAUfcOLfU7lHmgerIPBL
         dtJjRvB1Tno01fwgT7kQ1ISLLdiXx+6Pr7MaX/pzglF4B31ZeaNsAkeyplEsn+Fvd2WY
         JggWISjPHGiSQuH7lpOozGbM5nFJ7YLitiBPAU18Aqa7gGj9UD+v4MNoamFe2EM2CQbW
         QvthSlPmrBtKaOgAPdnz5UNhzxalJ1VBXHwekdg05sO/4b15GJizTXpnHYdm/V6TkrHO
         Ut+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778496568; x=1779101368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cqsy042krG1n2vy+fiyMYLPnlvvdawLZm5elNuTwKzs=;
        b=bQdTmnGgSRAOjyuA/fTKvgqNUU2NnBQJHrXqdx6oEBrk1AyXl+BjcmD1sBhT7QtQRL
         h+iyMPBgyZOYUI+N/MLBJESDftTHhFihsrCqmnAEhq0fcpRCj8cClTBfrZ4XF48ybl13
         8OgJXcT4Q4PJoudFlT9hzCwr6sUQnnrgwR7VBlhe5t22y1HqJEbAJC5dvPUQKu0W25wP
         b2F2s7wknRbJqANGg+vRT0gc7nV3T2tfe7rjXF69Fm8S1sXj/DLjafgI9blbiV7ws73t
         MUbLBEuzj/grdk47sBhXwwuV4OM5SH08ALftoLKY5FkazeWP5gy+XZHWCDWPSmdINRxO
         te5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778496568; x=1779101368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cqsy042krG1n2vy+fiyMYLPnlvvdawLZm5elNuTwKzs=;
        b=D/EIAFuM5lXak3ET3921JqWtT042bBq46bPKrD5adt+ga8I7ZrWbTiH7XTCCiEM2ti
         +6kPpJzXaNwztfHP95F4NYaveeMzRGpwVB7TpDIAg2+CK/PJ1WUMrWoShOOY0d2UPDDh
         XIhaa5pcuWTvwJFUwGD86ctjklPLfYfSaXHSeiEWxSUGpxwFczCU1kYbT3ApOiS6xx3v
         5Zc0midzMVJGbbY08IQCNK6ZQhMOxvNLbEL4T97c2BBco6kn/OrpdWbnyhEbtvlDdAxO
         dy7PHHDFrIOP0U+F6K+t9tBdmCIgJjuj8U7wtfAVFYZkhy516usYR4wyhk/3AUhnBnJV
         z1qw==
X-Forwarded-Encrypted: i=1; AFNElJ9WlZQdCAbSZB2hjpYH7dgVbqMwkeJQD1NE+0gW2PtS8lGVjuuSpkfn6keJzLx3BTb8uN93A3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcN2oFgGydtYxhGj4wJSor9qHSLHTcOhVr7GLLdT24F2To56su
	eq+ff+yEaM8ivxD6m/lDo5rBoIp0NWraSivW7WOEXO9YcJ6CFlHD/o95M5zNfPEuSLM01qh3eSs
	4D+OW1Ulw51yAwBz6vX5As/RFS8jY5PkvN7fz+dlU
X-Gm-Gg: Acq92OFr/NuFoSbojhMihSKVw4avXmYf3B3HfNEUkfmlKb7+leB15jEt4SoUA0q5EJ6
	aZs3/NmTP8bIIH0uATYNQKKPk5qB7Hdbnnnyp7TGC/poB+iPz3ZN53iGPIIQWxxfZcr6uLfpqOr
	v9+1RvywOl06FgfmHF/LCxqBVNFN7oMx9IroMbVnlSCB4borkFCuBtDRxNlCxwgMVzfsIAraZMq
	/Y3wWTzgAjnz3SLxVRsT4ZLcjTzTO8CY4zj3rETkhNMgiuXynYnDNnHiyVRImgdc2gloJhSSwSZ
	Z/9p9ZJlLsvLnHm37+Gs24kDrNtrE1cGFc7pnnbAMlTBui2ywTvrVADHu5TwMF/53KLYVBrYIgD
	d/2COXvuWQadDIVThnz5Zf8fAcol11Q==
X-Received: by 2002:a05:622a:5ce:b0:509:4406:44e0 with SMTP id
 d75a77b69052e-5148e896912mr196649081cf.27.1778496567269; Mon, 11 May 2026
 03:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1faca91179702b31da5d87653e1e036543e32722.1778259798.git.dcaratti@redhat.com>
In-Reply-To: <1faca91179702b31da5d87653e1e036543e32722.1778259798.git.dcaratti@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 11 May 2026 03:49:15 -0700
X-Gm-Features: AVHnY4Lk3oAdg2K1Vdf1A4M0mr54roOb5XeBfsJfairuxnKnzvci5f63oH49HkA
Message-ID: <CANn89iLb_Khc8cTB8MFPqU9gCpP4XKe-6umKpZ6e8zM54M+NZQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: dualpi2: initialize timer earlier in dualpi2_init()
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5A80650C31D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286603-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 10:05=E2=80=AFAM Davide Caratti <dcaratti@redhat.com=
> wrote:
>
> 'pi2_timer' needs to be initialized in all error paths of dualpi2_init():
> otherwise, a failure in qdisc_create_dflt() causes the following crash in
> dualpi2_destroy():
>
>   # tc qdisc add dev crash0 handle 1: root dualpi2
>   BUG: kernel NULL pointer dereference, address: 0000000000000010
>
> [1] https://lore.kernel.org/netdev/2e78e01c504c633ebdff18d041833cf2e079a3=
a4.1607020450.git.dcaratti@redhat.com/
> [2] https://lore.kernel.org/netdev/20200725201707.16909-1-xiyou.wangcong@=
gmail.com/
>
> v2:
>  - rebased on top of latest net.git
>
> Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdi=
sc")
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

