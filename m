Return-Path: <netdev+bounces-278545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCK8Jwt13mkqEgAAu9opvQ
	(envelope-from <netdev+bounces-278545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 19:10:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CAF3FCDFA
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 19:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E965300788A
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA0A2F1FE3;
	Tue, 14 Apr 2026 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gapp-nthu-edu-tw.20251104.gappssmtp.com header.i=@gapp-nthu-edu-tw.20251104.gappssmtp.com header.b="YO70Vymi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA422F0680
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186632; cv=pass; b=og4DCaQMG5O/qm/yIMvUJ03lq6KwgeqFnwl4Q1xb897D2phkSAa3Gn/Uyl7jr7FaBRw9KSCR7WrFBfitgyOoMzjoi0LcA669aDNdx6WOLQAgfClNGt0rgz7xRbzupP5QoF7pLz8CiPA7H3qBsCWEMUsvjOmK66U3/pAJDEmqpGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186632; c=relaxed/simple;
	bh=+C5gxulxYbRR3SbWHYeNUWNLZ1oHahEG2liHjARIGWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNIh9/ZPgSb9f+uk4ZC8bvX8kD4G3P7NG6Vah7G6rs/mg9KY/Kh6nvvuvUxchCItpeYe8EchLjR49C7Qwwt8Cn4eZR5p+NvKbmiPBJv0og5PIWHagvGX/UKcs29yuMD/KsOsADGofKmvqfp/ov7uYoIgjNkdlGTHcGyKFatrf8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gapp.nthu.edu.tw; spf=pass smtp.mailfrom=gapp.nthu.edu.tw; dkim=pass (2048-bit key) header.d=gapp-nthu-edu-tw.20251104.gappssmtp.com header.i=@gapp-nthu-edu-tw.20251104.gappssmtp.com header.b=YO70Vymi; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gapp.nthu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gapp.nthu.edu.tw
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so5160436eec.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 10:10:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776186630; cv=none;
        d=google.com; s=arc-20240605;
        b=YjuG7kIQVMI4WTmAUIDYIb+/S+AC/l23WJqkPDW4VMXuUaaxvCkiAwl6G4ZSZnbbZx
         JTzr6Js1a8llw4Wz7r862VkE+XQTr/v8YFpx7E8cGPh8XFN37VFckV5Xd4c9jb+TrVeZ
         Febl6lng8yC7lYD1j3NTQMAwocHIAKb83WSH8yXK2aEwCDWrvDuayhY9uYYZlYFRw3pv
         DJLK+uBZbk5G1BVev89EpdOr57ngfRLTw4VFDZigMYRw0wLiG0cM4wNkpXzyqo4NPzmz
         UgeMOoH+PJLyJp1ZM18MBTQkpIIBC+zgodMFqwvlA0gz1o+fDqLH2vY+rHTxZ7KxPMHP
         sJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1k1pmDF3MC0els7+Bgf3YZdtnxl4D6jqcqI3VFjzEHA=;
        fh=HT17dO3o7YaX+HIahINDXXcTfMwJClPV2bBJ2HMVdGE=;
        b=QWlPlLCa7LLvPQB7E4b5EkmypoBqg3mmobhuDUPhyhLfQxVI7+2dbKHlPOImXDY2Z+
         6RC5YoiVRMM6Hu7K/oY6o+mZt7RHb8f5nXS6DMiZfGTe4rYiYF5/zMj0O86h1doUht/2
         2I0zQqNw5z2R0ZHX4NWqhAvjwUhBm6ToeT74FwxOAOe1iUarkWVvirsuM6oDJPiEUNpk
         tAm6VEh9H7bNYC+ku2/hRRtUBarQxfg80oZrsz8D25XPW2MxwhcUNqcvONpOfWeUpOFl
         rZERa+X0IKDSa7V8KzuviQ0l7c1l47fMqjMh9y41Wg32pC6PMYoakxOLJpVD7yGff3a9
         IpAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gapp-nthu-edu-tw.20251104.gappssmtp.com; s=20251104; t=1776186630; x=1776791430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1k1pmDF3MC0els7+Bgf3YZdtnxl4D6jqcqI3VFjzEHA=;
        b=YO70Vymi4SykQat9i/8vxJHSa4hKg3Ku+RhkyMpOCjl69fzBzAOKt2KjrVUqA9Vm/V
         EM84UxkYQTkGzmPJNFuIpD2kVOnJ8pkGCydR/nPf2o0iVoOP3qvJmfhE+ia4R/BjZS2A
         /yZGBz9VIeGeu2QmZPYsjpF9qPN6/0YvlH2T6gckTR7IhyWjOIiXRkfYmvymXtmmZPw3
         Msz1ptopleqW3392AfHI7qAzBKj0Y97byR4FBfgKeRephluld4OYQDgjw2ThjVvDjvkX
         2HBK4MIN1wqkwLcpGfouFnzxInVCc9AYMmkHzmYuRhTSgXacTOEFzF9iN1F2i2Ep1tf3
         2EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776186630; x=1776791430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1k1pmDF3MC0els7+Bgf3YZdtnxl4D6jqcqI3VFjzEHA=;
        b=hxJnJJPzR4ODtUxJcG9mxh293xaPH9HYJTYFzRGmrq+u/oNQSi5x1sQfw8xKpPwB1L
         3Asq3ehTGNJeSAKMmuIe+M7zkmVITkLTpzbXpv7xHuy+oP294YIzl6etJRGRcC9+EKaK
         iATHW8eMl8Ok/h1YCfQOXCXBHqH91PEAJs53TNob0rMTjtTaBLyFNj/G6W8F5coy21Xo
         Ul7JTRuv0AKrhCCoxhOq/27cZ9Qtlbu5NHAdgGRWE5sTmvUAuxVehKiWJzCfnSNkInJw
         SySU7lLp6jxBSJ7PpFHttrgGgJOtt/XHgG2NKs+WT7rdZfLmlkrryBdMg03whSoCI3IB
         K7tw==
X-Forwarded-Encrypted: i=1; AFNElJ/ckurLqOGluSXRbwdvBE4h0KSq7AraMWroADLezob16uHvtHZkOx6gv1CvmJGXAdwRLjUi1Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEMarXyoqYok1kjpryCQTyQ7Cc3kA+xwUb2MoElRqLltDuc3r
	wHWauX5EHEv9LgK/exHvKshjfRCA7SvSGS5FR1DjPjsFgjEMV4FjrJDCPQxC13y5MAlA63Vdajh
	t6w4gl7LfSbYEk6NnLnWmPS6T/BJiTF42TlihSSuNHg==
X-Gm-Gg: AeBDietbf38rJzdbLjtyqan5WaUPQtVGnEPN3GNOy3mCdL94nwFginCWQwBZAsSSXQ0
	zDirHeO74igQUjif8M5CwQhgoc8BH4dcl84GIzKwGbtaRfy02NqC45aMiGuKjXroJKIzPR3lRJQ
	dbIhXuoHZebi66VMQS/kFPfqdLSezg3yeyhQCT/UcmC8940sCU509FKcMWXylo7hTLv17UmMhE6
	wDo/ZJg+vFw91NZuyPJMusaa6nfIz9Nx0BzjVvCceW/QFyV7XsK5wo0fbHRKztlOcwSakWpntCU
	nInU17q6nC3lbtUJUW3raSFjWvQ4f4k7XPE0Kw0=
X-Received: by 2002:a05:7300:3213:b0:2be:10a6:647e with SMTP id
 5a478bee46e88-2d588e849a7mr9387737eec.19.1776186629589; Tue, 14 Apr 2026
 10:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414155652.7468-1-ku.loong@gapp.nthu.edu.tw> <efc34ba8-730a-4c01-bc44-ee64569d2d4e@lunn.ch>
In-Reply-To: <efc34ba8-730a-4c01-bc44-ee64569d2d4e@lunn.ch>
From: =?UTF-8?B?5Y+k6Y6u5qau?= <ku.loong@gapp.nthu.edu.tw>
Date: Wed, 15 Apr 2026 01:10:18 +0800
X-Gm-Features: AQROBzDKIEnQtGvk9dSrsjk_zo7dkArEprr11loawkL18olfgzq2ehJvMl8AvQk
Message-ID: <CAFS7P6NijSQwToTT52TbR-9mv7sPmF4GCWKMDAAgq5WrLE-nhw@mail.gmail.com>
Subject: Re: [PATCH] net: mdio: octeon: use %p for bus id
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gapp-nthu-edu-tw.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nthu.edu.tw : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278545-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gapp-nthu-edu-tw.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ku.loong@gapp.nthu.edu.tw,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,lunn.ch:email]
X-Rspamd-Queue-Id: 52CAF3FCDFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for the clarification. I understand the concern now and will
not pursue this patch further.

Best regards,
Chen Jung Ku

Andrew Lunn <andrew@lunn.ch> =E6=96=BC 2026=E5=B9=B44=E6=9C=8815=E6=97=A5=
=E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8812:16=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Apr 14, 2026 at 11:56:52PM +0800, Chen Jung Ku wrote:
> > Replace %px with %p to avoid exposing raw kernel pointer values.
>
> What exactly are we giving away here?
>
>                         compatible =3D "cavium,octeon-3860-mdio";
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         reg =3D <0x11800 0x00001900 0x0 0x40>;
>
> Isn't bus->register_base this well known value?
>
> You also need to think about ABI.
>
>     Andrew

