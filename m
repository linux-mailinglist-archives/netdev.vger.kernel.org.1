Return-Path: <netdev+bounces-253697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNSiFoc8eGnsowEAu9opvQ
	(envelope-from <netdev+bounces-253697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:18:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1D08FD55
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 721D6301A398
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0AA30AD10;
	Tue, 27 Jan 2026 04:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXqLkQ2g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777642874FA
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 04:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769487492; cv=pass; b=dSzYAdlzQik0tqkNDYvlxq0wzXsOFVFWdNn+mj+si4bvspjbd5ZLAg6v8M0VAk3BWTE7h6IQEE5swts0w/m5jfz1KMaosEz2uTQT8YqgpT0gFKUJQf3MpHVP5VBoNlL+eHBf281M6rS3M+G3MlccL6CnMjenLNk2kNuldNuY7QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769487492; c=relaxed/simple;
	bh=SI2GWNuzEg0dpiHIi7ElpwGfstqPn5JPS5rWG5xE9J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMOIy3x8e0DwdQshGgj/ZcJBO47eu+HvN4+Y+s2b0gw9yWcKENlQBg10LfDfl+8AEaRM/xQwnpG1kGqSJmRwFxQxOVgqb71Q7eteJHsksneL0vhrrgetF21zSfWYxPV6trBKgEhsiNY3isOffi3zyiwYyWZTlH9si8/ikxq1pgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXqLkQ2g; arc=pass smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-88888c41a13so65872366d6.3
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 20:18:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769487490; cv=none;
        d=google.com; s=arc-20240605;
        b=XPZbtb98FohUKF0aBQuqA2Ij9tAfd+S/Ylf7+DKfw86K1PM2CakBlRhtOTr2d1LBri
         5HbEgRFhYc0uUobSQRpkoPL+ia4fAO1GWJnUXfLV4Xxc3G5t/aLeOags3kyDej438wg/
         595CrNLVTR1JETc1ImVCojpoSL1Hv1B5xbyiTdq+PPmskucncdXtfRQfrZhAfqRKQjNs
         olkTop1zfMmozohQQ0j7l3n8fUDG5EcjN1SKtDgrdQ8QIBf+aJBfEiT3vK2lCPjDNgO1
         2BQul0s9FiNu2cptKLcNnyKkpdZwPno7vnBjvyvym4UawRb/CFXbfxdcSxGq49MpzlUN
         WrVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mSAunwMNxl7rufFlUr7CZTRvllLllvBwnmcbPiu7/UQ=;
        fh=NyrUZ6hSRBWU1wVjCq52kSeOE4XKbFd/W+Q0xPm/Fw8=;
        b=JJXqNyiF0m8JEqxtflRwTyyyfB5eKDQwj2WKhOkLcPeRA+nsS54/MSU21hsnGg7XDL
         UW4ysE7eQ8i4RQqVK0gHx/lKkNZUNCe1RqrCmQksd6apOcYgI2TeGlEdl8lrvhXxrujv
         b5l1tEM4hpIRarpOVndwoHS8HxJlPfnhDhrvIWAR64ktk92ugKXX2BjljoSn+8I+f5Us
         lCmilZzcdoQP72gohR4f1GX7Fuq30KpkpcL7XqO78XTA47Mnn/TtpZ2WPBEd8WP7Nxyq
         pcI/LVa6Ox0SNQTyFyEtopf4Hv30x3JPsTGw2QHGW5LfYaccuj3q0J5jAZ+x/TNCA2E/
         e2ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769487490; x=1770092290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSAunwMNxl7rufFlUr7CZTRvllLllvBwnmcbPiu7/UQ=;
        b=cXqLkQ2gHy0JbCI8CWzBoDyxTN8UOUfFGPLCraRTlIre6xpZfm/21S6bvuxPsZ0Bd6
         SrSirSCjkmCkV9IYLUNVHTj4UHNx0gGXmXsCd/RaOg0v789g7NYJQ1KIFUBOp5vC0wyr
         kv1Rwu31sBNyuD6gKjLVmZX8pZ8BMvYcgH1jzx8tPd0+0B9rl3F8scORQWMK5pC471ap
         M/Mu2AFRhpi43yDgyx8jG9z7c6Eu6M7bETtX5cwJYEedZdGc/4+fVnkb1vmTn1bYYD5F
         uRBBmlsX9WmGB2iZ0Je563nl9LDTfIQMLZ8R8oTjeveMGlJrT6FesTmsZKzDrFCMImmS
         ocNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769487490; x=1770092290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mSAunwMNxl7rufFlUr7CZTRvllLllvBwnmcbPiu7/UQ=;
        b=muUrCMDFv9yfI7zmFVm5u9xWArOXYII6H/HrBtYhRpj+XgNFsiyvkyNVxZUhJ+jiY7
         RYaWQqqBjlPOrdsN3jPdPOJ/nbX/xq0OlSajJOVU8fWf9/QaLTdRBqyQm6PVHiILCV4P
         tXnuvJa9zT8VM3QD/hVI38zxKuxZxNTZIssB0CYGnA7mveeEp+id+AO9f9bCj/1ZUcFH
         ZTH/EJeCru0H6Stn/7v8VHbLjbDW8+mGoKldoVsC1ZlNS9+6e00D/1P9e+vIsw1xcRde
         udew+37er/WficX9WyxhM0r7J/ziy3AZKvvEI7pvzazgnfQCrt8x3wyRf/YUtM1UcLHo
         W+OQ==
X-Gm-Message-State: AOJu0YwuGZWg+IrhPXAPOppDTmNlF8e5d6pK+jt239fX4O8Cb0GzKyKS
	VQtTDTBv9MJrL3vdmXoZwzANEDL+ZnMx3ALrhaV1BsbNTpoM65Ef5Exkvq+WiJQT6nb/EuyHuQW
	ttogx8mLBCbWljTZdv9o8914mcH4CYP4=
X-Gm-Gg: AZuq6aJTj/OKeWoeFPqBZaOMnp9uwtnMSHRfpch814BzP4wDYw9fIgoYcrR0lUEIY5D
	Dm9xWkM2PoNdkHP5DkurLhpoWtUygfFglSK3+V7fUaEHCTbAWehO29u9NlecWgpaiAr8Z70W+kg
	2SYW3oJR+gkB62x8BhJu1kHyin2GmWgUDEcf2T6+f09Ou3z5DdDKQTAp+RNn0+HTLHVjr256OYi
	J/6m6E7asbw0x3Nb/01tSiXPCyeTrBN2p0Gjah4ntvMX8FUC4ZXxslfSvGzETF1SRDIx5YQcCKK
	5Hckp0ka7mvqgYXFPkAcMtNg+u2nFyHfBjr2Yn/HIQjWAmRFyOG8jFFUsx9E
X-Received: by 2002:a05:6214:765:b0:894:71b0:6afd with SMTP id
 6a1803df08f44-894cc93f7f8mr6450546d6.59.1769487490251; Mon, 26 Jan 2026
 20:18:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123065842.53669-1-enelsonmoore@gmail.com> <20260126192611.5ca0e9f1@kernel.org>
In-Reply-To: <20260126192611.5ca0e9f1@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 26 Jan 2026 20:17:59 -0800
X-Gm-Features: AZwV_QgqZ03BL1S6IF7jgSeOXyxXOEqhDwXZsuGOX7uL0gqhUZzyrbHV4LyNUHc
Message-ID: <CADkSEUhUtR8SuQALcBNVf5qoRTrBx8HkL+PmNiM3QQDwRM5D+w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: usb: sr9700: remove code to drive
 nonexistent multicast filter
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Peter Korsgaard <peter@korsgaard.com>
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
	TAGGED_FROM(0.00)[bounces-253697-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB1D08FD55
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 7:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> > +     else if (netdev->flags & IFF_ALLMULTI || netdev_mc_count(netdev) =
> 0)
>
> nit: netdev_mc_empty()

Hi, Jakub,

Thanks for noticing - I don't know how I missed that, given that the
original code was using it.

I have adjusted this patch to use netdev_mc_empty. It is now part of a
series of sr9700 patches I'm still working on, and the multicast
filter removal is separate from the other changes.

Ethan

