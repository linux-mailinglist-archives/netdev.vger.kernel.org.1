Return-Path: <netdev+bounces-262736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMkjH+67pWnNFQAAu9opvQ
	(envelope-from <netdev+bounces-262736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:33:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A195C1DCEC8
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEB7C30B59BB
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0574141B352;
	Mon,  2 Mar 2026 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTHu4mnk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3201F41C0A3
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468914; cv=pass; b=ITYlZFC0bOTTQR7ttGLHp7ZZ2LZa3Tje0FWs8zOhyhBp3ZOSOVeJsrbBewEhYvaKeVhed6p6xJYRIMMSi3CbKaru3Vd5mWij4ms25nAHtkeg/b/QUkmQNV6JF9aIe2gHmSFD6U4/Rlu2CBAx5zxhVTcWam/QQKp0qHHzJ5HxlxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468914; c=relaxed/simple;
	bh=dMHwqYxQisMntrA1NhfwmZ21wfBMDsPxJFujDbwlTqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctS9bB8YCIbhB7lTicxlHJI3HSilI13CcBRTTmhMVZ8KOdkRxuwJ46Aa2tgMjbdBcYGbBgYutT89RXL8GeDbL7h4b1xwkIBXgE/XBvwyfiigpPPfjGHrjHzilub2O3TD9c2zympAw9BgM9Iq6Lx0RoQvri6Rn5vMbmFrr6nkN3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTHu4mnk; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94de4f5531eso1472769241.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 08:28:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772468910; cv=none;
        d=google.com; s=arc-20240605;
        b=dctJiFeFjPZcrMMm/lvTsW6enzvthfbddELI4/gZK/iBpyU6lIa+vpzlree0RJNURl
         4ybNs9aw9iqJuOBypob11RqryBgI/dwAD2fJo5kZzzFnLRft1lQ0WA4YoalSj8NDDoeV
         V655TBySorT/8bJcA/VZsPt2Ew8d3kkSts5224FKyuLfyDslRWsSQDI6HLcSkNyco4pv
         TkARcKO5WJxMyU8Ia094/4/9Lz8NmUBcD6dO4NB4Ef9FrA8Ay9afbcv44yjZk1VtBT2p
         H0nJ1y0dgn2Y336+cMinDr8m6RawNlxbH0NcYBXviRweIip0O8ELpqxX1z3I4FTnM/Qj
         fqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DzhZQOue2L9j4aXZ4jUdotleq+eYfW6Yii7JRxHrKCk=;
        fh=sEYrufs3FzHEyD/lJEirXGrtObCv0NJvNj7g2ZtC+R4=;
        b=BQr4ZruxkrTd00R5vWdrC+RNMn9S9/NQ6dykNZYWqThtdjQ746n/TEMQTb41Tq0us4
         8GhUV/iyQZKhEAKHvnxB6ta2ppc2HiAzp2jOzUy/aIb2UEKlGPavowv3zYFC4RuEZ+hn
         7JQwwpPaZaRApmVJjAeRvqTIw8xL4fLAMklkKfBjNaqTEDjS2P6R/X8ReQbsCFS33BWQ
         aAZrXS9/BS6e88nCqCI8zUMRi/CzjagosonB+MP0F8gisBqhC9wLOfIui0jBPOI73m4/
         TSUjZlvch5c687rrYtDBgxXfvXX4usshwvb2WT/28o/SCRqOLlaWqTbx3xrSlLMvPO17
         az9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772468910; x=1773073710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzhZQOue2L9j4aXZ4jUdotleq+eYfW6Yii7JRxHrKCk=;
        b=jTHu4mnkdq4Mp0Wa+IUHaToBXRPHOla3hdUrd4M2LBO7vNEQ+CG8clGQ4QfXN06RT6
         QYS4ap6JDWOGi/qhQMUX4sTZCIQ5FG5iPpA0ff5LHyTh7kxQqB1Z0qlGpnpHDfkb3GbF
         S2E3hu7GtlzwV5XPZKS4VVShxQIfFVT0k9tJTWIir5Bm8tfaJayfFmUY2OUR8b1ZSkqB
         NkxTIYJg02A6ipzkL0ZbR5OWMGEyeoXGgCIob+TtjNNXw9cl0CYXSGnnc+o3N3XvNKki
         hPUyOdjVT3TdL14qdHkNDrcbVdGKgXGRt4eL/hUpZbCZotLS3gfyLTJHhFMQDChL+tpF
         l/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772468910; x=1773073710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DzhZQOue2L9j4aXZ4jUdotleq+eYfW6Yii7JRxHrKCk=;
        b=YKG3eQVFdo7ZMTygQdoiF9Pb53Ul3LQNu9HmJhjSGj0lYlvpg0PDMnYkx8YelOXHWD
         qrXjD4NF6ASNJL4qO0uDwA6j1GQmzGUcoVMgD25wEa7tt8HbgfAQJOrM5Wmgwvk6Nh5L
         MXjXPkGYMiAdM6XFTV9g3K3HSlafz7Vvmqep3aGkiFyO9lrGHJLKD+uTojMTCsN6ADbA
         zYcDsXqe9mMNN8VX4DOzdo7+4FfzDLyueWokaoap6AK75llnPUj2Ihq4Q5R2ndqSCVgq
         wFiyE5wY1JJxVaUcs/slCUFE1PqB1+Qy4RRmRxZF0lhG0XSb+j5AKz7NoRIgZfxsJPCI
         iAmA==
X-Forwarded-Encrypted: i=1; AJvYcCX5XBgjWiC7lfEpB9PkeKyrz4VNeTp8e7COmFpE0puFTnbvxFZLxTjWn2P6whPko9UQcYWOtSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi0QFwxczpO78S5D/oHyixPGBGaPqZI2xoqiKFG+kQx1uNWwtv
	jZxSRhkk5K8400AJx0W13snJ3+70pZxwlg9IN27q2nzD2+G/vmfLxbrRSNeQc+k/7gRZXFr7tGD
	iHoCth7HnWNhHJ+SagERYQV8xLp7BmSU=
X-Gm-Gg: ATEYQzzfuSaL8B6OlUTGmtwnMINAhnaaWpRWGiEN4Xs+YIesCXEPzG1CYpnSv+DFEfH
	uWi/76baZ/UUrLfVvIZjoxTPKFf/5CnEUXeB/vNmtDJ+xVbiPENitKtQS6BCkq+tPWhcAiHsJFZ
	43h44lkJ3wzKnGmPt6m222n1CT7Q+wTFkSmfTioq0WOpxIh/yQG03Atf6SAZpG9a/6U+fxr3dCp
	mrX2lQLyYJcvbd4XDlg+dfEUk+tlMFGONkLCJWeHOt+Ib2advqeJQ+MuskqpNG1wdTrJGWNhnrl
	pZ6XRZycv3K2oJas
X-Received: by 2002:a05:6102:b0f:b0:5ef:24aa:986f with SMTP id
 ada2fe7eead31-5ff32280163mr5192254137.2.1772468910139; Mon, 02 Mar 2026
 08:28:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301161709.1365975-1-seanwascoding@gmail.com>
 <0a784056-f57f-4634-aa7a-fd0b5916f40a@lunn.ch> <aaWP88PplFTsAPg3@black.igk.intel.com>
In-Reply-To: <aaWP88PplFTsAPg3@black.igk.intel.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Tue, 3 Mar 2026 00:28:19 +0800
X-Gm-Features: AaiRm51MTuyaW8sCf46M4X9momxmkR1idtlRx24QnNR4DCFftyUCbovalbjZGjs
Message-ID: <CAAb=EJU7QECk4Bs67=_q6aKbL+knRG6DBJa0AQRs_+014zZC0w@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Fix compiler warnings/errors in SUNRPC and MACB
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>, 
	David Laight <david.laight.linux@gmail.com>, nicolas.ferre@microchip.com, 
	claudiu.beznea@tuxon.dev, trond.myklebust@hammerspace.com, anna@kernel.org, 
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A195C1DCEC8
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
	TAGGED_FROM(0.00)[bounces-262736-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 9:26=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sun, Mar 01, 2026 at 06:39:44PM +0100, Andrew Lunn wrote:
> > > - Verified via .lst and nm that both variables (buf) and helper funct=
ions
> > >   (nlmdbg_cookie2a) are fully optimized out by the compiler when
> > >   CONFIG_SUNRPC_DEBUG is disabled.
> >
> > Thanks for doing this bit. It was needed to show my guess was correct.
> >
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
> It already has your tag. My Q in v5 still stands: Why is this a series an=
d not
> standalone changes?
>
> Also I just gave a tag, please split these two and send individually.
>

Hi Andy,
Thanks for the suggestion. I have split these into two standalone patches
as you requested:
1. The SUNRPC/NFSD macro simplification [1]
2. The Ethtool/macb redundant guard cleanup [2]

I've also verified the optimization again via .lst files to ensure everythi=
ng
is clean.

[1] https://lore.kernel.org/all/20260302142931.49108-1-seanwascoding@gmail.=
com/
[2] https://lore.kernel.org/all/20260302161818.63651-1-seanwascoding@gmail.=
com/
---
Best Regards,
Sean

