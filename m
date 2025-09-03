Return-Path: <netdev+bounces-219657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3518FB42868
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A23B7B54EC
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBA435208A;
	Wed,  3 Sep 2025 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="lt5XZwrz"
X-Original-To: netdev@vger.kernel.org
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00EF350D7E;
	Wed,  3 Sep 2025 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756922233; cv=pass; b=UDwRyiwDXMDRtR/gXIHZsuZgxn5W22BUUzErMwelVq5dXDP0B8jk+fNFAgwRHjoRKb9AtgJx44m096vAT0BAg11Kr9jcsUrdW4Hg9sArJ24oAiJgtrvsgjCU+kLEa0ymWy4XrvyWkQsfVsMjXLSbvnscleksnoKHUJeOG1JoT8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756922233; c=relaxed/simple;
	bh=xWaMQ7dVtqJM1hwK59xQ7uLpqa+t9EL4ZGNQx53GTxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFzqAzKLJ/Q0au05QAGYnlwIbbz0SkraddXDUbLOj61Ge3AgJrvGArSQSOEX4jdPYtPDtLKMABV2fbXaghnIh3zQtYudF7KOut5SbeWOpCB2WR5RMUqIQRwqNhKRB6mqQy9+5PpQR1lUluBK+JFReIjyyDrSf/ucjsu6iyp9U44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=lt5XZwrz; arc=pass smtp.client-ip=23.83.212.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6B452849FF;
	Wed,  3 Sep 2025 17:20:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a267.dreamhost.com (100-102-90-158.trex-nlb.outbound.svc.cluster.local [100.102.90.158])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 038C5838E9;
	Wed,  3 Sep 2025 17:20:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1756920036; a=rsa-sha256;
	cv=none;
	b=5m2Yf51ZG44B7BwxMBEzC2KfBeQJIvORDYa5tpwY9P82Xo4tNUIPzZGg/DvfCUNmYGDpIN
	5y23oNSsnrIh47dL+0/l0b+QFKIkE5qna98c8lWKMFqYyfPgClwfwatF4PZjXqrflIIs2C
	EQQVcBs2v79HDMZ3fVqG8s2E0hOKeyIheVFoMvww0dCAQWJD1/IS+iM01Oz0qFVLewhcii
	oGUN6Z/OU34QiLxzqWUXigsOZZ5HkPiNjLVkw7zC8eOQhQ5010j7u5HZKIAuh/X89v2nnS
	ktGy/LMn6T3GLHwuUdNzuJm25m0YI832dKJD7+fjSrdONhU03uO9CEQF28UzLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1756920036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=xWaMQ7dVtqJM1hwK59xQ7uLpqa+t9EL4ZGNQx53GTxI=;
	b=sux4pWIe4VamQiwbwsMxKAPxHRM/L7nxjoRaRHyywsWj07in5+/sewXq5+1O0Hx6FOS0VT
	0GopkysBxTcL1UKc/8VaUsVlhdqD5sc+zgkpu3S7fjoOFpToec+cavyMn2FWyuix87+jW/
	XPiDBXYoUhrgkG9TbdtWxTwchcbFP9t62+QJk8Qcx6Zj7H1+bb2Oed87enzW2oe5diq0Yz
	C8cJkfTdQ4mH4l0sMP5IwUtA93G9fv99YVbP9ps/VQ+4MwUm7ho9dhqhh3PvWDCphs3m4R
	qKGRFPNgYAr4/ibPI3e3+jQejqUlHeCKW9B3tR1FONeHOIl2578gOXDkVNkvaw==
ARC-Authentication-Results: i=1;
	rspamd-8b9589799-lbhhm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Towering-Towering: 482a2d8960fe1f3f_1756920037295_1615045819
X-MC-Loop-Signature: 1756920037295:2098147381
X-MC-Ingress-Time: 1756920037295
Received: from pdx1-sub0-mail-a267.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.90.158 (trex/7.1.3);
	Wed, 03 Sep 2025 17:20:37 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a267.dreamhost.com (Postfix) with ESMTPSA id 4cH8Wl0Sk8z32;
	Wed,  3 Sep 2025 10:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1756920035;
	bh=xWaMQ7dVtqJM1hwK59xQ7uLpqa+t9EL4ZGNQx53GTxI=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=lt5XZwrzOijlWhs0vkrGLHtk40d4+o6Pbpay4c+fth8lRnZrp6uhHoUxO75WQRWt/
	 w2OJEHUfnEpYv1qHvtYnfy13XlO0/BTP8Gn6bqwIMziEjVOuQLMAlQKxGzw3bN4cxp
	 odA8lEWEBteOWj9hYwaxH+DW2NTTPcrs+HvvhkrypvpmqvaQWD5KEDmkXedoegCDXY
	 fk9NJktdjAUAsRoF+LTYqpas9V0fmI+w04N6uvbk6gSspvY9DWY+VRWiS7QB38WXEQ
	 IBBSN05bQThGSsOzcqcyDLgjU/kPG+RHjvKRik8QaOxK5mEMvLDMWZmuwiaUUZW6/k
	 wOl7kq5n49DVA==
Date: Wed, 3 Sep 2025 10:20:32 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>,
	Zhi Wang <zhiw@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v17 15/22] cxl: Make region type based on endpoint type
Message-ID: <20250903172032.vfffqqjnwnzbl2id@offworld>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-16-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250624141355.269056-16-alejandro.lucero-palau@amd.com>
User-Agent: NeoMutt/20220429

On Tue, 24 Jun 2025, alejandro.lucero-palau@amd.com wrote:

>From: Alejandro Lucero <alucerop@amd.com>
>
>Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
>Support for Type2 implies region type needs to be based on the endpoint

s/Type2/HDM-D[B]

>type instead.
>
>Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>Reviewed-by: Zhi Wang <zhiw@nvidia.com>
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

