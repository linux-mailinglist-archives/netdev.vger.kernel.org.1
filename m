Return-Path: <netdev+bounces-205659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F1DAFF88D
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 07:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E844E7B86F1
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 05:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EA124677E;
	Thu, 10 Jul 2025 05:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzpPsJmw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E80D2905
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 05:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752125883; cv=none; b=WXqUKE8BES5iGwRRa9GV5AaKGfPYJltq/oC2Tr008FD8TlAOmUVGObe3cl1kCKMGHMHLuCtC8oQOIwmryc6ob4eT9eEKd0HxwuJf98qKu8N+A52XRcIXXTbH8m8+/3LHQgvNwBsnOHrxMb3eS4hhd/Hm+HK8wNtd+eZ9lz1SQHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752125883; c=relaxed/simple;
	bh=QlNqlpe9g7Lj70W7FFFHV8rmMJVgN6QqhWtLCrh5Lwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8LBo+7+qnWa9FaHlg8/gdhjAm+IejBsM4ftPlJtUxGw75LeRmS8LLcLENhLKrF9RuQnr1v0RNhJ9Kn9W1bzXiVDhI4kPcVpA2KFz3P+MCl92BmjcrhUwjyvKWMm7F32S+V9rWtAnShdyGzIy47IEIm5tujlWQyKJ+5ZEt1oUtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzpPsJmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F40C4CEE3;
	Thu, 10 Jul 2025 05:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752125882;
	bh=QlNqlpe9g7Lj70W7FFFHV8rmMJVgN6QqhWtLCrh5Lwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JzpPsJmwh+n/8ozLqfE+Xd4nKwAFOB0bcdG3xt1UJM8/IdKMFW0QL91I4iCzIasWH
	 Eb5xsTlQ/RHqq+V0blx9URpbaTivp1Wm5CT5JBwe+SNyl0cTSQbn3J9w1mZKsbuMSb
	 eeHpNviayGrJfPWl5bdVoUeDukMWd/ewk/UBg26JzGNC2tcbLowBDtPb8otDj7/iSi
	 FAPoDyPJfw85sz9+77pca/6584Cb+2pr82TG5OTTbTP41IPoHWCWAhuS7iQNBHYQXv
	 DBqVi2QaQtuV72okqu8FipOuwqLlNg3fqnhLmichk7m8oURZZihLTEnPrECjaoYMx/
	 2cdc/sB4htzOQ==
Date: Wed, 9 Jul 2025 22:38:00 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Kamal Heib <kheib@redhat.com>
Subject: Re: [PATCH net-next V6 01/13] devlink: Add 'total_vfs' generic
 device param
Message-ID: <aG9RuB2hJNaOTV3e@x130>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-2-saeed@kernel.org>
 <20250709195331.197b1305@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250709195331.197b1305@kernel.org>

On 09 Jul 19:53, Jakub Kicinski wrote:
>On Tue,  8 Jul 2025 20:04:43 -0700 Saeed Mahameed wrote:
>> +   * - ``total_vfs``
>> +     - u32
>> +     - The total number of Virtual Functions (VFs) supported by the PF.
>
>"supported" is not the right word for a tunable..

 From kernel Doc:

int pci_sriov_get_totalvfs(struct pci_dev *dev)
get total VFs _supported_ on this device

Anyway:
"supported" => "exposed" ?


