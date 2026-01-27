Return-Path: <netdev+bounces-254036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id czmAEP9LeWmzwQEAu9opvQ
	(envelope-from <netdev+bounces-254036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 00:36:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 905ED9B6DA
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 00:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 451133008D13
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0B72D838B;
	Tue, 27 Jan 2026 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bXDOvdon"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D1E28469A
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 23:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769556988; cv=pass; b=X8qlHSuKaMnytkIRc5AucQ5tw/oHxIbUZBLxreEcw7LeEs6Odu8kFynVIOSJllYZUOoMSD8PR5oPixieXMOzyhPLYrFL/4/h9txlV8RXgPuh50UNRZ0EJNGSXW6JhtgIOaWtcc26Jfz5LlJMmpgRIngJT0zL/T2YyC1ZkjFGKE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769556988; c=relaxed/simple;
	bh=oKyBdSgbpFYzBMy5ObP/M0psjtd9ZdeOjgZkvc+Q708=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjg3S6p1e+OdvnxMSkqE+t+A2jgYAiJjBNA4E+QqLrH8b42zzB2GDuYwAA0m1AdUJftvUm+H5UGkSjdVf5+ghfshh1zU2SXjYWJuvJ5sG39JuODokzokzIopk3LPQ7oWXPz4Hx+3qDhWn4A0eg6fJ6C0YWV7d2oeM2mn4+wv8Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bXDOvdon; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1233c155a42so9012086c88.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 15:36:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769556986; cv=none;
        d=google.com; s=arc-20240605;
        b=KaoXOn7Qy0Mx55eQyQL60xluLxL207GlBPw9060vH23dLZAMFcDOmkuIQuqpSZnvxO
         AyhdFQCvXgaPR56ccyxUAmJW9Jsnr265Fhm+lZUPtrA3b8aoPKLbnPA4xXln7YJs2eG+
         jVe/+nlMNC9wIEnjDN3A0KUHQpsHQ66o/ylRt4Y57RWuxF0w/nFmUShRjDL4VEMowVDP
         eB+UvKPxzVi9l+D3mBGGiYgSMDTlXJSWT4gaZC4NyPVvxONTItT9pqyvyWqgtOhxJ4Pn
         EVyE+6LcIqdwuL9fh5gIb4Uv/0jLkob3W6gfA80LIqD5HOL3v4Vd4RdpmnW1KwGtJLRK
         NutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oKyBdSgbpFYzBMy5ObP/M0psjtd9ZdeOjgZkvc+Q708=;
        fh=Sr3Guh0aG6VJHbXW+HQ6gBUUeGVfNpnmICwt5eYlS2I=;
        b=Ck8y/8TOfj89gKeia3DoVci6t+uyAVBA56PwuqjVzxbYNyweAStLPpy4kBP1Wbljz6
         SjLS4kkWxrxlgJpdy7qIP/a/PrvHp9XSfa8Ur2Z4Vq2gnDLGlzpp1NVEIwP2ApXzZXFO
         eX67iiU51c3+Ti0fUOoMR3OctR5GoKZhJiMJL/BWcZx3IjLzVYsCZYcI5g7KSgVbaSsB
         tBrjbtc+zNEqaUbBsVHkTPOdnPN1WENgf1hjidkAAXWvivDzQM/jXKdbqn3Vb2C1MjGA
         xJD1nzaAoFQIYJtyJFoR6h3JZmmF/wbM2dAenaT5RC3h3lfm4j31gQ7BKuz15jOBO57T
         Xe2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769556986; x=1770161786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKyBdSgbpFYzBMy5ObP/M0psjtd9ZdeOjgZkvc+Q708=;
        b=bXDOvdontsf9ZC5ZaZz3SIhqF1Rkuxc2ez2K6wen1w9cIH+BNu65xmSGDk/wqkqQPt
         4VAbdL8Uxaer7SHCnR2aogW88vTCk98RUsjAqn1cgW5B5SSwajwhew9UpDSKWHz3cIrW
         Mw45Tn5i85YmO0MHY/rysm5Bl9dsVlTH1bGuDyxoTqpBIkeQYzYkWD29Wr/runGVkNzi
         msiXQhdZhB2Iz3fGCpJHV+uEOtiMokwTjL0U8Jc4YlVw5nAc3Ng5wz21XmznO3TSSJAH
         1Z5jBkTnV2HEpf58bdO2520D5ocKHFG2+msws0+SWtYyxEAMwr4tP8QuUlpkkKisNcEm
         EBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769556986; x=1770161786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oKyBdSgbpFYzBMy5ObP/M0psjtd9ZdeOjgZkvc+Q708=;
        b=iYPRofpiOH7LKDuOun5PEzjeIhwkYnziAmj6LPmKZoZnf8ra7nwuF4jQkp+ze16hGh
         Zo6U/6uxU5reBnXDDy/E0SQ88DbxCjKoFoY0ZJRetxtmXAtqAYzfF57+1RFR77PNf2sg
         S1/Yz4EMtSOUnLAzIU2Sj663qwy4PW2/+SncHq9YG8Lagpw7rnaat5A1B+HtZX3k9YaJ
         8HbOA06XR5O0GLPTeANfeIliXir/s2do2mpT6Gr7jar8B+Sa/xXi1wx0Q90V7lcm69Bp
         1AruCiLWyR3IPoj1Rj9WTYpQYriAKXt6eYbICf4QKhScha1kH/jciFD9pz2/dP9ZwbOY
         3W5g==
X-Forwarded-Encrypted: i=1; AJvYcCVuC7Wuu20PSOacdRGnPs+vSs/G1o6hn+CK0K+mZ7GrMcbT+Tug7WZKAfwSTPQB7sLy0Xl4osU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk4LZbyM3sOxYK3j3wSIsN43tUvp1IY4R1nSniwpm2/efupBx8
	99rG0ZB7siBQ3XDaDbabJ33NESpdlewC36MlR8pdJyA1KESCQjMRRdPEnf/YOpopY3FpAygMY9d
	IswURhFXvlqiDOrEDy/quXkgItq6OwkU668u1oVyC
X-Gm-Gg: AZuq6aK+0CDp1w9t4rY43Cy4vjpu1HcQ9o6M0byoWJ4KkpJssqiRrC1RG0Xu/stXy9N
	7zyYswNUl35qVXkNTRK6ZMt017ZyAJXqrSuI7MugFNvPxNdxoD/nwmIdEMWDnh18KMvjNjl5TVS
	myGBxCyUq3bn0qqSph7PSPMqrPvatLQ8KeX9l03vsAUiELNlxwTUPOq/5mol4VZ5zyAy5nrgS9O
	U83SvIQdMs9aHWech3HG9pM+yy7yyhD5MnD8n5IieWTOj79MLLZ76Su4ERoHKOrk9lSqS0QZUvF
	2LbzdjI=
X-Received: by 2002:a05:7022:b8d:b0:11b:c86b:386a with SMTP id
 a92af1059eb24-124a005d23emr2116677c88.5.1769556985955; Tue, 27 Jan 2026
 15:36:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123204058.651080-1-brianvv@google.com> <IA3PR11MB8986BB2FDDBB664CB318FB15E593A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <aXj652w2_ogi6ysW@horms.kernel.org>
In-Reply-To: <aXj652w2_ogi6ysW@horms.kernel.org>
From: Brian Vazquez <brianvv@google.com>
Date: Tue, 27 Jan 2026 18:36:14 -0500
X-Gm-Features: AZwV_QjWoxjQ2IyE58EkwujS_Wda4iWgVwAJUWoQZ6k4jRVWrPX8AnwG2cxiXI8
Message-ID: <CAMzD94T=VS8J5A1VZH_KriY7BMHf90rrGEK=4Jyuzc3SxHJhKA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [iwl-net PATCH] idpf: change IRQ naming to
 match netdev and ethtool queue numbering
To: Simon Horman <horms@kernel.org>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Brian Vazquez <brianvv.kernel@gmail.com>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, David Decotigny <decot@google.com>, 
	Li Li <boolli@google.com>, "Singhai, Anjali" <anjali.singhai@intel.com>, 
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Tantilov, Emil S" <emil.s.tantilov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254036-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,lists.osuosl.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brianvv@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 905ED9B6DA
X-Rspamd-Action: no action

Hey Simon, last version is v3 it does have the Fixes tag now. Thanks!


On Tue, Jan 27, 2026 at 12:50=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Mon, Jan 26, 2026 at 07:27:15AM +0000, Loktionov, Aleksandr wrote:
>
> ...
>
> > I think could be nice to have proper Fixes: tag, but anyway.
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>
> If this is to be submitted to net (via iwl-net), which I assume is the
> plan, then please add a Fixes tag.
>
> Thanks!

