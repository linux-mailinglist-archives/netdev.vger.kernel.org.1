Return-Path: <netdev+bounces-252379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O3pNA9EcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:36:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CA569008
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFAE098479C
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0090D34F262;
	Thu, 22 Jan 2026 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+k9Kf2R";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qz4xW+pK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BFC34B40F
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769092575; cv=none; b=LxVwaPxF17pJWmNbmQpJ0KWNNCol1Apbxf1nVZCr4IhN8hgDVe5DyzPGJsLpmsTbxCfvn/vqOnPhK2QeIp7BGB15wAuBDzj56CV4YZ8V0+PMG7Ec6q6jGWqpX85PW0Wkj10ysU9ImQ5Y//bo9sZp5b+dcdSEJpPXTVHvrecfYGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769092575; c=relaxed/simple;
	bh=oUSkpNJmY0xJU72nm4mAJJRfKSHFJiXY6nI3DcQbCbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T/5dUQS5F/wHFzJeCflItdoYg9MJ9azyWdMaeaHt3/ObJ3o/Ow5JkVbAd7/iW+lFcKJ/cAWuZgmbgn72ZHXILXVsznLmuqzxnZ50kiuxkH+RTzFquw5jHI7gamP+KReww5UYGJNSkT7tiYZf9aQX7pJbI/En2B33xsR3O4w+WBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B+k9Kf2R; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qz4xW+pK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769092571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HsvOuFjLTr+YqXVe6RGyDhXEKiYKtBULZ5xPe6pwFaU=;
	b=B+k9Kf2RJ1Ozfz5yc8B3Hrp2bG4kyMq6SfXj1T9GzfJH/ZMd1ewJvMe1qz/5IsK/XOu6Hl
	px/Mo22wZ4SSIhroa+emqS2maKvOSpxw1IlIaiQkL/NGTCL8cbdAhOlRmz3Tp8LKl8noIt
	IcCMNRnBZzDHDPKEEfs9gd53JmitOEQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-4AVoGP0dOVKZjfFp4YuqTg-1; Thu, 22 Jan 2026 09:36:09 -0500
X-MC-Unique: 4AVoGP0dOVKZjfFp4YuqTg-1
X-Mimecast-MFC-AGG-ID: 4AVoGP0dOVKZjfFp4YuqTg_1769092568
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6581d41ab79so1209464a12.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 06:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769092568; x=1769697368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HsvOuFjLTr+YqXVe6RGyDhXEKiYKtBULZ5xPe6pwFaU=;
        b=qz4xW+pKTncxtM0SOGwG/aMPiDe/HhEW1KFd9rUOAzX0uWbAKTTDP4DEHnZeHJYPVT
         610KfFJjhxEOBgx9rtBZCUvjhonAjgtHIRCB5gasfIPmC3QEauZX4R1ozjTeQq+n371j
         WnRTmr+vfV8zgBZ0XTzKKWpBPkhn7TYiqneNNyxuo4dxZmqrG4tpnUCfG/9onO4Ehfob
         nWmdD+TCgi4AEWYCATRKofbD3lvP0I3UoCY4q/ij6kDXWkjN9i8J1StLu33Qmgxhq4tR
         z07LDbSomZL2694u7Zdfyl1fm9vZvv/dl4NxKpQXby5J2DjIDgzPMwZohbOePtUHEO4C
         pABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769092568; x=1769697368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HsvOuFjLTr+YqXVe6RGyDhXEKiYKtBULZ5xPe6pwFaU=;
        b=WKVyvSc8lSFmKYEcow2FIsP84NdWwdiVIetDeGFODtXZkGIB7CIfKjweAXW8AtJolf
         +61G5cUp/EbHears3natQ/Zo+VYng3ZzlaQ20UzblVDnI/on4R8hgfMvWIDoRYokM/XM
         JoBDkyeYoeiXBg96WhIKwCYXJU7zW4aTrcrob3PuTPNOC3jB09E8oHuRJDX0EU/QZw9F
         ZXc4tEMybr8t1+Q4ItrWN0JewcY+dk1mp9F3sywgolO7fT9GdG5Ytfbh67djt7GAV9II
         u96Hd58+kvqQOj9rcDJKQiot679DUZl0bIYVS7iKIiUVou280k7fVAKjFcUFED1XBdPu
         oYVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWemjIbFqQACn9WHM4E06I8+GPRMtv+42fFG/y3rD1ivgNs4dIu0pjC89WmJlSdq6ylOJB1kgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzup2YH561fJm6kPSP3P+5Fy0PRClGBaHsjcf7CkXuxQdp5h8CJ
	wCzX6gvvSpSOy7sH/cab05hu23N3kFcKGxVF3EVdsyYU7NFdquyx+ccT5N6yHBqwxEh7Our7Dw/
	iv0ZMVAz7d+vzxakaeNK+fRKAEPuAEBARYo/QHCwCEQFrTe0EkbShkLAfPg==
X-Gm-Gg: AZuq6aKXWnIjZhQXi3+BwZCLSXBMnYJsjEKEWUav+BJDRrjLOH+3my+Z1FM27z5rZis
	yrTYPQJL5Tyd/7MmOJ9FrpgLFcHwy7uq6u9naD6GqxF5zMFbq5qc8rsG+4hi9PcsvMYSV9J1Yrd
	QgBdrhoIBrD/g+YcuAKdA/06ApBdd8qQ73bln7Syg3MpzzGuSQlgp7e30c2FO8wdqTbQGXR++cR
	me3SKoaFrbm82eHbFyWjRBcumUWhZXKX/sUDoHsMGf8nLiPHlQL8xC3SomQ2sAmHW0crsSFYcO+
	O0dyfFK7M2xcn8b0Mk+ryfEH0sDgK1UZFj+STE7CMBYDoeHKjY+CBLCu9ohOUBHuGHhogtDkaWs
	twT6cDgwoaz9X
X-Received: by 2002:a50:cb87:0:b0:658:dbf:d1a0 with SMTP id 4fb4d7f45d1cf-6580dbfd2e4mr4103600a12.30.1769092567809;
        Thu, 22 Jan 2026 06:36:07 -0800 (PST)
X-Received: by 2002:a50:cb87:0:b0:658:dbf:d1a0 with SMTP id 4fb4d7f45d1cf-6580dbfd2e4mr4103583a12.30.1769092567343;
        Thu, 22 Jan 2026 06:36:07 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.175])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65452cdb0e4sm15970133a12.13.2026.01.22.06.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 06:36:06 -0800 (PST)
Message-ID: <d681a9d5-ff37-45a0-8398-3e770052177e@redhat.com>
Date: Thu, 22 Jan 2026 15:36:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] mctp i2c: Enable SMBus ARP discovery
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
 <20260121092328.2308705-4-heikki.krogerus@linux.intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260121092328.2308705-4-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2605:f480:58:1:0:1994:3:14:from];
	TAGGED_FROM(0.00)[bounces-252379-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_PBL(0.00)[216.128.11.175:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[52.25.139.140:received,170.10.133.124:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 49CA569008
X-Rspamd-Action: no action

On 1/21/26 10:23 AM, Heikki Krogerus wrote:
> Since the SMBus Address Resolution Protocol (ARP) is now
> supported with all I2C host adapters, every ARP-capable MCTP
> device will get automatically enumerated. Those devices just
> need to be bind to this driver.
> 
> The SMBus ARP-capable MCTP devices are identified by
> checking the interface (MCTP SMBus/I2C Transport Binding
> Specification section 6.5). The interface must match the ASF
> protocol, so all devices that use the ASF protocol as their
> interface will be probed by this driver.
> 
> Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0237_1.2.0.pdf
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

This patch depends on 1/4 but it looks like it could be a follow-up to
the main series. If so, I think it would be better to re-submit it after
the relevant code landed in net-next to avoid cross sub-tree problems.

Otherwise I think it should go via I2C tree - and we will solve
conflicts as needed later on.

Thanks,

Paolo


