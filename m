Return-Path: <netdev+bounces-261121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNZ6CO+rn2m1dAQAu9opvQ
	(envelope-from <netdev+bounces-261121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:11:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7885E1A00AC
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F39033019B93
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5901B374753;
	Thu, 26 Feb 2026 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WseTGvba"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DD6374193
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772071830; cv=none; b=u0FJs36twQJ48DPtNkTtyaWdNlRpCZTb4I0Y9bQ7UcuvWEqswZb9gRQgwAbRWQKJ8jPM9oRZ+KRBR20siAusiS6fz+bVFtHO0euhuo9lOfc4211SlMflxLZ6XezAv9a94hTE0uXtWaFD8XonDCLCs7NyTCXtBU5LgX0jR3molQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772071830; c=relaxed/simple;
	bh=6E28dy9r3Sp+NRdZMBmCMEQWDvuIwmiE4LghEM0da0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apZ6NywZB5GOaH7G/0bBUu7xRg5jAu+yf/XCDRrtA6KKtxJlq+mrL+oDthaE3SQhTeu/mNDv58tCEIoI/NkQnPlq107po/24qf66H5q+61no0NJ17zMVAew98D3EbZ29pxffN/RvoZEzdFwhIMFHQYbzPbce4yyaqBliJsrsO58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WseTGvba; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad9f316d68so1332845ad.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772071828; x=1772676628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4mOEzlF5WfXh7SYCkHvZdArVwTunpx1k40WIVxQv49M=;
        b=WseTGvbaB5jQ+NDpARRBIEBBfaPQ0u2iL6kYo9PpZulpRFhhz00f/1iyb/FY2Xwslw
         zys8REPIigTQrxRt7PWCNEfv8Ur3FGUhduBDsVgitqsV7bud32JFHUuSO8wG5vKqBZKl
         w1x/f5lkABxu+cvnDW7D+RMBhE026PSP/nniRkV88lQ4+8zXbxaXyEJC5KQeAuVXg1tB
         CnbeuUj6W+/rZjEvZGin47xhnrue0XyZKpfwS5MweTcT6fBdodBQ+khEyM4TvbL7alun
         2jb1xr/XnVkCXce8Cw6WNMuJ0FnAtDnuFWL4BMrIm4UZYDcH7ZtgZqgnh/XKBquVUryx
         yX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772071828; x=1772676628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mOEzlF5WfXh7SYCkHvZdArVwTunpx1k40WIVxQv49M=;
        b=p0CmLw6vruLuVSpI+KLi5xz0oobsjtV4C6Mtpzb4wR3+FM+d5JA2VlYWbdG4eaNnti
         m5ptEeWcqPD1ra6uduWc6z/LV1I8tXf/eSjm9r2vjZwcpwstVmj0jlVp1nn4+AsQ/0ub
         4iL9Ex51QksgvF4v6eaIQ8DkJoeObfxHOdj0NuRaR+jvWYKWeR89NcK/CDMMUNhptWPs
         yQedPNEytVHdeNKE/4A1O3OH3YQ6IjCXWmwgQCLQrEOTj3abP4Z1+qBOSnq0HPkU+Ilz
         VIwCFPzhFJ4fokNFNVqXQd5z3Bz76CX+veJErqiSXKrd9SSaCjkFMNiBFiKriinQkpEx
         kQHA==
X-Gm-Message-State: AOJu0Yxi+lCuKu2K3XUSgHdlqfbKNyYb2WQN4zDccX66FrWtkAv83Voa
	HLSzE+HdHPfheaiV/r6J32eFUh0iKnC81g1vCW0E7zk/N2x+XziGiwhR
X-Gm-Gg: ATEYQzzQkSqQ+Q9RgvVw7ktWB6SpUg0psWtAZ7Qfnz1sHe20UAjEnG82ehQFlDQuO/B
	hI752YHd1rbAdPnI6U7X7wvF4up4AKETqUwB485GzBHSBg2EPoATlWwVzLt8PrbaL7LNUqD/SGD
	UMjACLTa5coHnI2HJ8Oru4yjPvpKoClsbaW05N8gZUCTgK/BzsnZLQsmd5T7k++UTwjsyMtbebG
	CfwH3vnjQRjB7s2LEHqIid0fE+7e5tqtd5ocJYBCVODIujJ4jOqjWzx+yc0O5r3A0bpfczWiPRV
	mK+pv2Zy3JHffAvzQqvXCflj3T/y/y5hLzG7uS7NOebOABFgqousNBka+RnYLqz6lwDB9a0sJuI
	Aa3UK5AG8B1vnxT/QUoNu8HdCU0RVMwFHpEG2JoYA8g708kg0FpMNAw+gHOd+Px/d26LcRrwkvp
	QlV21epdOR1OAZXBJFY4oT0lsr1qA=
X-Received: by 2002:a17:902:d2c7:b0:2a0:c942:8adf with SMTP id d9443c01a7336-2ae02969954mr6118965ad.8.1772071828409;
        Wed, 25 Feb 2026 18:10:28 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b03ffsm7454675ad.1.2026.02.25.18.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 18:10:27 -0800 (PST)
Date: Thu, 26 Feb 2026 02:10:21 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH iproute2-next] iplink: bond_slave: print actor and
 partner churn state
Message-ID: <aZ-rjaU32FbTbn9I@fedora>
References: <20260224020215.6012-1-liuhangbin@gmail.com>
 <20260224020215.6012-2-liuhangbin@gmail.com>
 <20260225132239.34fba967@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225132239.34fba967@phoenix.local>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261121-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7885E1A00AC
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 01:22:39PM -0800, Stephen Hemminger wrote:
> On Tue, 24 Feb 2026 02:02:15 +0000
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> > +	if (tb[IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE]) {
> > +		__u8 state = rta_getattr_u8(tb[IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE]);
> > +
> > +		if (state >= ARRAY_SIZE(port_churn_state))
> > +			print_int(PRINT_ANY, "churn_actor_state", "churn_actor_state %u ", state);
> 
> You should use print_uint for unsigned values.

Thanks, should I post a v2 version for both the kernel and iproute2 patches,
Or just the iproute2 patch?

Hangbin

