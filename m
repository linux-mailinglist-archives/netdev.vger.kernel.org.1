Return-Path: <netdev+bounces-238072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2758C53AE9
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 18:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 919933464BD
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99E7346A0D;
	Wed, 12 Nov 2025 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqsyl7HV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B169E346789;
	Wed, 12 Nov 2025 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968279; cv=none; b=MPWeX0QHrl8mqDm9xyMhBS6DBmqeg0/PITjVyYgy68Li5kERLPw65dkPNAeO0XNPsW6lfwDyB4bZNuLi8zXmL/BnXM6MOGgdcdXImfRU45TifgK02MhBphhX6EgxKHfxHRDsfO3aU/tKeVL9DZD74osNU43nOOdInKsx8/J3HPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968279; c=relaxed/simple;
	bh=QzbG9Zmf8V5mGCi08mrp59QmAT9mLrHn5LXHCXH1Cs4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lgjc7WWov+udvgNvaIkg19eJzrlUX0pAnz1P0kjtYJcaKF0Wb0fcaFbJmK/qzaHD1uVbezQTznJQ1v+PjK1j3orZfjE3BqaZjRm8MxnsjZMFvrZV/+LbvL0Xk17kuAGOZnxVoXlwOPrV+j9RsyBPCpR+1KchzU7rIS8obVTeVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqsyl7HV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C23DC4CEF8;
	Wed, 12 Nov 2025 17:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762968279;
	bh=QzbG9Zmf8V5mGCi08mrp59QmAT9mLrHn5LXHCXH1Cs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cqsyl7HVJTxYC4dJx3oZLQXWspIuXMbp+3M/TEfkxGItR+56Aobw5UF5j5Z3wQwXG
	 4XZ3lUbgRzKzlM1KJiTrHMVk0tKa3WhbmBTuMsQ5vYTUpUQMgNUboe7cN6t/HZGekS
	 2HT94E8BjeS/eFwslgk63t8/1lvNfPDpg7wR79x3yx3vxDsbDxfH/fguI/jErGqPCu
	 GcZmEndX2qwuRaSP6UdSlCBljtVUM3O0t6G1iNAcJl3w581oLabPXlIxe3z9R9imwi
	 Zu4ybNBoKIKwsiOeyteXgHVNpX29L4Gxyib0BTmn54JeATXBXe3DoU00rtYz2a9Ip0
	 S83/FkExWnRmQ==
Date: Wed, 12 Nov 2025 09:24:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 vikas.gupta@broadcom.com, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>
Subject: Re: [net-next 05/12] bng_en: Add TX support
Message-ID: <20251112092437.34161640@kernel.org>
In-Reply-To: <20251111205829.97579-6-bhargava.marreddy@broadcom.com>
References: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
	<20251111205829.97579-6-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 02:27:55 +0530 Bhargava Marreddy wrote:
> +const u16 bnge_lhint_arr[] = {

drivers/net/ethernet/broadcom/bnge/bnge_txrx.c:717:11: warning: symbol 'bnge_lhint_arr' was not declared. Should it be static?

