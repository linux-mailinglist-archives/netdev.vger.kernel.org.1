Return-Path: <netdev+bounces-267782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gg5XDC6btWkr2gAAu9opvQ
	(envelope-from <netdev+bounces-267782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:30:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8002228E258
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3A953017258
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D991D5151;
	Sat, 14 Mar 2026 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGBCMHJm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5B2BA21
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773509419; cv=none; b=LU3AcvELgp6715ro3EfoSABopCBjWBPDrJwtIG7jdQEkslW6LmnoDOAU9+zZvH8DfsWyUWMkxzhz6bOigkk3wX7wG52Tk53NksKhGpt6/dHdAZ6wQkD2zRmp2iJup9Vf1vIj1DLN0Cgdr5+xcHfUUeZnrZwbEj3yHEQBt2ggg/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773509419; c=relaxed/simple;
	bh=nozoOiyuL4946dP0pRIk9aYOui2jffhC8Lf7e1ZPc0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVftlfhly5cXnhdi2g0yE15HjniwwG6GAqoDJbTahuwpMhSPNeMyFkaLxbCCD98Vr3EQwdB8tTLCfNCggGE27EIq9x1q64XFqApMMvo8uaqgGzEewq8Ry8IJQBmvfT5WBcv/rchx7w0QgM5H6ZmzjgfUF8OBhuh4ShbbrLtcFvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGBCMHJm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae4e538abdso35867475ad.3
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773509417; x=1774114217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgNGRPvsiGZpwGxpvIWA+Zg88Lb7uF87FvEdkpGfT2Y=;
        b=BGBCMHJm6V3vZyHG3qoUljhTBTpGpu7Mo4001Iu77HdkXn3gRbNSGCUhox2oOcVXML
         7P57TgLZjFMaT9IupYsXVqzsAp/fxVgkaVn9OUSG5Ahz1vU5NKEtQjgJCTI7JUuQKx2f
         mJywG2u+WlrFXjVxIQHG/F4PcGJWDE3tL6yHVoTpsQFgI8YGTWTf/dfy+Yp3aely/2qr
         uGQgdWM912WaUE62YubOx/0GnNA1Fm3nXsgtG61EFc9sSgw7oZQo0ZLzXr5eWUFgyDdF
         Q7fJp2+GWHidjOd87BQqrJj/jnRNfhd++lBcqEXdadXrAWa3IwL7b3RNZgFQz9Jrj0fE
         /ptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773509417; x=1774114217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgNGRPvsiGZpwGxpvIWA+Zg88Lb7uF87FvEdkpGfT2Y=;
        b=PeLc8l4tfRHeTHkKYYFzav4dLy56tBFmq22ghXI5q0Wkwsh+bHykSrnKnqBr1BdU+G
         0qRxtSVSK6LUWOsblTKsFWFs0qPMwZXtULW733oqGdALyy0JLe6QRwk16l2DhXQm+J/b
         gc+ZnC7BRuTPDC9ho7hzshJTIuoNdHN3HjafisE4CoMyZb1hw5EhDxpcinU/NBhDdhd4
         nXl7Ip4wkFiIJa0UyiwFGDsmiVH7wTLt5bLiFdjSgp3GHbXW8RDVyHpSydSr2aZQbQ8p
         pOpCAlsqLSt8kMIhOV7+06GfhCAF9leyJ5K0VizhxeLXM9p5uDV3P3Cu/ZBpJ+YKvoj/
         eWSg==
X-Forwarded-Encrypted: i=1; AJvYcCX+hHDl+X1h9rZOMBefQ1vXkYWGm1lvn3D/bt0yW3Lr/Y5SUx+wVxWhu++r2fF1zolTS+XO9IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgRXweFcS8k26IK7TNC1zWTg29N9fjp4WXmkq48USh2+TTI0Y3
	v7691ra3sRHTvmVDft4+3mbZoj3HuHa5jxKZh5HJMVJzvw4C/uVQtkj3
X-Gm-Gg: ATEYQzzaNZ+02anR3tKci5yJ7908h7xwlb0fEJuQkff+JzO7FjArLoX3AeG+KHnCQ0q
	ddotjh8hJtsDDWAbuNpLL6HTDB3wHcfUSqs21gcVD8FQ2R5gKe4hx2iGmMaSDwiU5tHfqhVM2LQ
	5mhyt6XiQOyVUXqBlpYWH9LIWqJJxDcFhIOxv/XmeuLBu7/jG3Mig1foi2zmN4WJMUPMgPX620S
	lGSgGaTwZyt/THP2s8Rk4JNnXuo5RTjf1wb2U8rL85dmXOWSQvWUHImT0z/mrwlEi2JoSHNvBok
	YbAkQRvN78/l/diDaQ4vwk1DgvnoF6aDNRApuqu1gfCIPe3FKrTzlg85KsodQp3tIjQEjmCq/ex
	EeBCkzFil2tzmf6q3ZFsUraoxeJVQUPMh9JtzB/HGefIeLHjTytMVa2ZLz/02L0NN3xdnpG4Qpy
	8kARoAgBTxe1y6BQWK70oz9yMb5PBn
X-Received: by 2002:a17:903:1a03:b0:2ae:a9c2:6c3 with SMTP id d9443c01a7336-2aecaaa8286mr85847025ad.35.1773509412772;
        Sat, 14 Mar 2026 10:30:12 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:53cd:7adc:9650:ee87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56defbsm51040805ad.10.2026.03.14.10.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:30:12 -0700 (PDT)
Date: Sun, 15 Mar 2026 01:30:04 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: charlie910417@gmail.com, jserv@ccns.ncku.edu.tw, leon@kernel.org,
	mbloch@nvidia.com, netdev@vger.kernel.org, saeedm@nvidia.com,
	tariqt@nvidia.com, chia7712@gmail.com
Subject: Re: [PATCH v3] net/mlx5/core: Allocate ttc_params on heap
Message-ID: <abWbHNv-6Wg6UzVj@eric-wcnlab>
References: <20260226114219.2111793-1-yphbchou0911@gmail.com>
 <20260226174601.2120282-1-yphbchou0911@gmail.com>
 <8b501a1f-9c5e-4f3c-a136-277fc24af154@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b501a1f-9c5e-4f3c-a136-277fc24af154@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267782-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ccns.ncku.edu.tw,kernel.org,nvidia.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yphbchou0911@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email]
X-Rspamd-Queue-Id: 8002228E258
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 04, 2026 at 09:53:15AM +0200, Tariq Toukan wrote:
> 
> 
> On 26/02/2026 19:46, Cheng-Yang Chou wrote:
> > The ttc_params structure is too large to be allocated on the stack,
> > triggering warnings for exceeding the 1024-byte frame size limit.
> > Consuming excessive stack space risks causing stack overflows.
> > 
> > Allocate the structure dynamically to maintain safe stack boundaries.
> > 
> > Signed-off-by: Po-Ying Chiu <charlie910417@gmail.com>
> > Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> > Suggested-by: Leon Romanovsky <leon@kernel.org>
> > ---
> 
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Thanks.
> 

Hi,

Just a gentle ping on this patch.

Please let me know if there are any further comments or if anything
else is needed from my side.

-- 
Thanks,
Cheng-Yang

