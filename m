Return-Path: <netdev+bounces-12436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCEB7378FF
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 04:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C6328142B
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 02:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067CA15BC;
	Wed, 21 Jun 2023 02:19:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE7F15B1
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B465C433C8;
	Wed, 21 Jun 2023 02:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687313948;
	bh=p8Q8r4aZhiSiJbdIqmN/Pz1WZl07k8vqIfS3U6C+MPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L2w0Kpopcb8BCSVb/gO9i9A9Uc8cNEQfhQ4HzzDZDnu4kg2w7SRCU8sPm8GnUohHb
	 IyskLgwHtapceBiUkHmFLd9KIraQWVeiE2axQiMl9ngj9lJtGuCVqANrVuj0fG0v31
	 SUA5YgB3N3xPQqQl0Uzz3PEU1PMNqzpJJKyLhTyn2rpWkIauPtq/LhJFlWykmxNXo4
	 pQqwEpQMLscQI4pUaSOjcACr2bL9nJ4daIm9inSy4KHvSRDacs2KJg6DWqWWVAF8Ks
	 WZmC7/8NmTbPadehe3Wb60XiFK7k2pzb5uqYMZ7qEBn05cSowvEe1uslgkLNSl42NF
	 DGrpmfvabpXcA==
Date: Tue, 20 Jun 2023 19:19:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dave Ertman <david.m.ertman@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 daniel.machon@microchip.com, simon.horman@corigine.com, bcreeley@amd.com,
 anthony.l.nguyen@intel.com
Subject: Re: [PATCH iwl-next v6 00/10] Implement support for SRIOV + LAG
Message-ID: <20230620191907.3a812399@kernel.org>
In-Reply-To: <20230620221854.848606-1-david.m.ertman@intel.com>
References: <20230620221854.848606-1-david.m.ertman@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jun 2023 15:18:44 -0700 Dave Ertman wrote:
> Implement support for SRIOV VF's on interfaces that are in an
> aggregate interface.
> 
> The first interface added into the aggregate will be flagged as
> the primary interface, and this primary interface will be
> responsible for managing the VF's resources.  VF's created on the
> primary are the only VFs that will be supported on the aggregate.
> Only Active-Backup mode will be supported and only aggregates whose
> primary interface is in switchdev mode will be supported.

If you're CCing netdev you need to obey netdev rules:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review

You have sent two version of this today (and there weren't even 
any replies).

