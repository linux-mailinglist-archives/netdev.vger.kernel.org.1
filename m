Return-Path: <netdev+bounces-269995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDh8BUeCvWk4+gIAu9opvQ
	(envelope-from <netdev+bounces-269995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:22:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC9A2DE84C
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AF843003601
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157E92EBBB2;
	Fri, 20 Mar 2026 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Alwmjv+M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48ED2E8DEA
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027333; cv=none; b=rOYvrwNokcx6fiKPNH0sBqGRylWlbmei8BKr7Cg8Xy5xSdqAKw+1JSCDncyT+ggBXB2jv0NeXkqkxZlWzKNcboYJQ/mzE8+vIH4Z0UsY80cpUKVBmNtXtttNeJYrjrSWUD9u3zWWFL63MOEim7mG6anBvS0MCe9rJ2jSGf7UX68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027333; c=relaxed/simple;
	bh=Mg3INqOpqyAJhgaigqIT74zNX+BsxY72Qaa/OghquoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5DX+TgkT52rr5yIHyVy3EOVtZsGo6tT24fLUpoxXpot2IaOj/loHtjTa1EfQPnHsW8jUtjiu5Wz4PSJOel9Ak2a2cdzIalCHallB75IQAkqfDEJ41XAxk7Zl+TP9RMQjgg5pcdhqDLbT2kPH1gbaDkxAHtVDY2UQthU1cRGyXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Alwmjv+M; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so16344405e9.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 10:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774027330; x=1774632130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7i5Ias5YzraA/kA03DLV1PJU1eKcypCkeyngdorE2no=;
        b=Alwmjv+M5k0y9R/2GA6Nc37Yw6ot80F50v8jYhjw7BP7ImyVR28Q1P4bUBfb+QQBlI
         7og0UJI2XH0WzPOWdythlQWxh3dpIuXF+4Du8D9EFxwWQIo4hYnhLBbZSCyntozLnL0V
         HWuPyV0rEsZgrNQRwPNkVIhIBMy5E9xN8MBTe9P16yoM+sEaT36Gfx3E5Z7/6B+m816Y
         E2zHhvb/oBIu+55GhIkCSS1KyOCiIvPoYQh8CWrscTQJutc4UoyJEQeIxdkLu/gNVoyt
         862PEayJgUyGjwFPeCCpvhVgP3kyFgcMMRRywCIK9OJLU3l4/hDU41MA0ttMSu6DGheL
         Xyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774027330; x=1774632130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7i5Ias5YzraA/kA03DLV1PJU1eKcypCkeyngdorE2no=;
        b=EGB+Se9idq6m98jcVSh8dUJ8j1hFJ/w9HSZ2cktWyZ1FeyK8cxUJlpfk7eOOAJrgp9
         INjgM0LOO1fx4dvvs6TiTOph5p5F1qnbJYqPSI0utS/Am7S5xjtkW1do13QhKFsX3gnl
         OPkWQFVwdH7hNPH8tv3k+G6wwaloZgaLGqX8TzYHSIcLo4i3o09igmE2wKrZ0bmsWY6H
         R1LgwD9Tmju93o8YKXNv893gAxKNW+3c6DCylxlMPCpkgENcizk/7NIhl3q9y9HaMSnq
         w0f/59cUe3ByRoi6i7nf7Bde78/yycFhrbxSxEN2ukGb4z+KVvAgBFJrEFFgyq0f8F2g
         xR8g==
X-Forwarded-Encrypted: i=1; AJvYcCUNHeOF78igiaYgKsjQCNYesFLrBbeqm29MtdfE2Y1ulVq/JTyCuLjl7erbENtDUrXbV9oahW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvXJ+9XqeV+Je1q8CoLbKRJ5lnwDpZSrMD0t5UtAzuYGmyWGzi
	uh7CCjo9EjI8a5Cxz2vP8tPePUwx/6SCySHiUIcXb+j3VFAFdlvOAnRA
X-Gm-Gg: ATEYQzxZET2trYemuznDwdo0TY8ixl0q9QS2kXl3PcSIMz9qn204IcGaRPBJ+1bIR3T
	dQWer9yEXcKGGNGn3aSS8RK0gzIpWoLbXnl6+Mo8s0uyNrkJFrtG/nQe+NXJaehtB+60ShvZg0O
	5IOQB3qZhgcROGBusDjY7ov8sY8DZRc0+bsnYy4nmKA3LtsNma1fzEPn3ljG0io2y3mjbkohXyC
	aTMSAIuTR/p7OmnkuEPZE9WQKzeGmeOrqfLWxV68kr8atg53fJW9TNCn4ZNud8JPO04AfxIuUwz
	FoHfve6C2u/1GwuWp8PwOWHpcJ2j7fUpqMcKfCbcIghDm0ehJx9jXmeO+vT2/t3qv1oS8rj7zR8
	fKQH5+TOO52xR7mVQ7/SCagAiAKhZedVSuqsgAMEBzrFoL5YZqLE21X1SY8xVcC4HzNTGu6cBbN
	2atFStijNpLl/cLiXiOzorWppt1TTca38SKYfnNI+7eVCPQzrtlbZa3ni4+Gblua/ib2MZpSbIM
	WYAu1a5aPXaKIOPXshX+PLe
X-Received: by 2002:a05:600c:a312:b0:485:3989:b3e4 with SMTP id 5b1f17b1804b1-486fe8b7afdmr54233265e9.6.1774027329805;
        Fri, 20 Mar 2026 10:22:09 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe87c815sm22104765e9.7.2026.03.20.10.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 10:22:09 -0700 (PDT)
Message-ID: <a22be11f-00b0-4351-9fe2-1f354ebe451f@gmail.com>
Date: Fri, 20 Mar 2026 17:22:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 04/22] cxl/sfc: Map cxl component regs
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-5-alejandro.lucero-palau@amd.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260201155438.2664640-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269995-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AFC9A2DE84C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 01/02/2026 15:54, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Export cxl core functions for a Type2 driver being able to discover and
> map the device component registers.
> 
> Use it in sfc driver cxl initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

