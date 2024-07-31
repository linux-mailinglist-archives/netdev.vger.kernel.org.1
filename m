Return-Path: <netdev+bounces-114717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 012C5943981
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 01:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A119F1F21606
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 23:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEC716D9C6;
	Wed, 31 Jul 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8heujrY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C0614B097;
	Wed, 31 Jul 2024 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722469832; cv=none; b=UI3w71ZFOi21T/7Rn2pG/p3LkdBATW/+7Fch79024WtKWiHXvLSWNDowrHyfHVRYopp2Gs93MzBVqxl9N0VOXG/QxK6kOrUJZSY0rXlTOF6RlwR9R+qkqLipILsPR5yaYl+EthCRmHunLRYCxWBY64Ioy1yVpHSlz96k64Y5SMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722469832; c=relaxed/simple;
	bh=XKedVoEPW7RtRC8Rm6Y3egUenG0nedLH6P9k6Jx1gRk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aV2MQYj08uW5mPadlv+3M0I+/ilJnClspLO3DyHpvqe8K+XeFteOJILF/YTAZKyOUTaCoTr+RrnEB/tzmQndrUZMQLWcATNxARshPdRRNSA3DHHsf+YHSBc69C5Rcm/cOwM9OXOY/RiR4xyuUGKIgNJaYuaV3gXd9iyqAcjQjmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8heujrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADAFC116B1;
	Wed, 31 Jul 2024 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722469830;
	bh=XKedVoEPW7RtRC8Rm6Y3egUenG0nedLH6P9k6Jx1gRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T8heujrYArnUrHtl+lxsGrVoK5iHD5NN8svKzdFg90LrpRyXhmXpIUtzmBcVtzpdj
	 IOi6SwuFcPjaPoMKpb5IFcabnDJs0Lt47WvBM7jqSofAnmsJowpJWPTHH6fhZwU38L
	 lTNSQlXqSWOrY7DIRdqwzj3ugXQ0beX/wsiL3wcKpvnRLcE7qsuUM+qKXaIaULvH73
	 rAPBRKRAOBAwM9Ic1IRtMuQZeeZ3f+f7mMDIcY1T7fAapRHKc/V64oVMwpQrIbnpku
	 Vg0GWWexZRekv2kWbstqm8SRFHuC+t4WoMQhxnQSJ8O7H65ywHzwn1oBSvLYqfpzJb
	 v7+njLbWXU2tg==
Date: Wed, 31 Jul 2024 16:50:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Paolo Abeni <pabeni@redhat.com>, "Gustavo A . R . Silva"
 <gustavo@embeddedor.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Kees Cook
 <kees@kernel.org>, netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] net: core: annotate socks of struct sock_reuseport
 with __counted_by
Message-ID: <20240731165029.5f4b4e60@kernel.org>
In-Reply-To: <20240731045346.4087-1-dmantipov@yandex.ru>
References: <20240730170142.32a6e9aa@kernel.org>
	<20240731045346.4087-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 07:53:46 +0300 Dmitry Antipov wrote:
> +	reuse = kzalloc(struct_size(reuse, socks, max_socks), GFP_ATOMIC);
>  
>  	if (!reuse)

another nit -- no empty lines between function call and its error check
:)

Two bits of docs to look at before sending v3:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#changes-requested
-- 
pw-bot: cr

