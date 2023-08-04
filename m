Return-Path: <netdev+bounces-24243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D949E76F6E1
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 03:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155041C216D5
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 01:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0223A4E;
	Fri,  4 Aug 2023 01:23:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF4B7E5
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 01:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D18C433C7;
	Fri,  4 Aug 2023 01:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691112181;
	bh=0YOOqNDX6DUFgXkNAnhHisbxGNkuwAzOA74c1Yrkrkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XOv22VH9IOgr4d+y5EBwJl9sdUAMdlaBAXyVMi8O6eITa90bo02Q7RPMZiKWhogxJ
	 eDS0RKwvb93ny655wBnzvoQk9iAKMjtPqr5i7LrJ80rXVx+GpC7VQCJkVPYhLdWIXe
	 AVvnWxatYw90QxozgbCBm8/nCMYNXJncbeJRRK8+FEX4jHLydNRp9SpJD15To+WPaA
	 HeQy3Ql8Gpo91FIcpdVJrj80xYNkjZ58rrf/5BaQztjwl+ONj+rJWTPjbXqjyrN6XA
	 uUYR98gZUbY52FxgyPR6VEY7VSG6Ni8a967DjiLMant4Tslb4Piyyvl+hPCgLTDniG
	 c7LlqxMcp5sQg==
Date: Thu, 3 Aug 2023 18:23:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
 idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v3 00/12] devlink: use spec to generate split
 ops
Message-ID: <20230803182300.2d7e9a4b@kernel.org>
In-Reply-To: <20230803111340.1074067-1-jiri@resnulli.us>
References: <20230803111340.1074067-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Aug 2023 13:13:28 +0200 Jiri Pirko wrote:
> This is an outcome of the discussion in the following thread:
> https://lore.kernel.org/netdev/20230720121829.566974-1-jiri@resnulli.us/
> It serves as a dependency on the linked selector patchset.
> 
> There is an existing spec for devlink used for userspace part
> generation. There are two commands supported there.
> 
> This patchset extends the spec so kernel split ops code could
> be generated from it.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

