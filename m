Return-Path: <netdev+bounces-53208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C9B801A0B
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 03:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D246F281EB4
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 02:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B3A6133;
	Sat,  2 Dec 2023 02:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaT+L5eq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47405245
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 02:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB04C433C9;
	Sat,  2 Dec 2023 02:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701484113;
	bh=TrnbxgzJn0kK3cn2TIMOJmaJkk8/yN00bIHbLIx9S/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WaT+L5eqhoWVXlMRgVHKTmy1S6yvb+AZ0BavrhLPTOxSNBITndUO5paGQhWn1k9ha
	 CqBhCclo+0h2S17EF9igMLxDRxA5DcEZwTfvIAmDcoPa/RABIvxVMmKUAcLSoh0z+4
	 ZDmjgsZqJ1EHE6mHskuRIWjBYi4yszGv0bhNvG21l5BWJrwmq2mo3Lk+FShTjgXInB
	 KXOYnKw4iRXewHS81NZ8JfYCWleHqonR/07DqYV7Ynx6si7h95afpkbQR0tkljX636
	 v/saFAYMrL/xZVCPPNK/+yLDTT0fICL2K8RchOgArr5mdJ63BdTyRx5l3U1jbYsNnh
	 p1mO1/ZRV+yuQ==
Date: Fri, 1 Dec 2023 18:28:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, corbet@lwn.net
Subject: Re: [patch net-next v3] docs: netlink: add NLMSG_DONE message
 format for doit actions
Message-ID: <20231201182832.6fd22472@kernel.org>
In-Reply-To: <20231201180154.864007-1-jiri@resnulli.us>
References: <20231201180154.864007-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Dec 2023 19:01:54 +0100 Jiri Pirko wrote:
> In case NLMSG_DONE message is sent as a reply to doit action, multiple
> kernel implementation do not send anything else than struct nlmsghdr.
> Add this note to the Netlink intro documentation.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

