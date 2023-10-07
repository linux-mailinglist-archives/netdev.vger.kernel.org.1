Return-Path: <netdev+bounces-38800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D177BC8A6
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 17:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E330281E2E
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227282E62C;
	Sat,  7 Oct 2023 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ns0WE/H3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037B029428
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 15:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56166C433C7;
	Sat,  7 Oct 2023 15:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696692961;
	bh=dI7Vf6iCe6cdUXeiNYo7FnhV2+HASKHA1tQ/ju+n2k4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ns0WE/H3SkV0Os6XJJhmHQGR8gJ6yW6St0imuJFbj0o4xuxoxQL6eB8qg5MRWh4Hm
	 el/0Vli43OQdRwLu6eoTx2feayCbvfxJq5fyXMUwZ6tUARVSwGaohd3WhWypHfBwSV
	 1HV1WC83cjq/K2fhIPjMlBEWZmkYuYHcsRGF9dZp8ysdrfKP6iVx1MqjAtJS0N3XZr
	 HF5E0uX0mvD47wQWBe9UuA7/w4t8ilHDflQ8eL1I9+GN09gKd4J2DFQc8lJnM5Re8Z
	 VtlNk9EQ6GgkPfJnz7+HowfiW4OXGsmOnbFse9Og00zHC/3j7FQxZ8U5ricVRSJ9gR
	 LVUpS33yUsgXg==
Date: Sat, 7 Oct 2023 17:35:58 +0200
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 5/5] ice: Document
 tx_scheduling_layers parameter
Message-ID: <20231007153558.GE831234@kernel.org>
References: <20231006110212.96305-1-mateusz.polchlopek@intel.com>
 <20231006110212.96305-6-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006110212.96305-6-mateusz.polchlopek@intel.com>

On Fri, Oct 06, 2023 at 07:02:12AM -0400, Mateusz Polchlopek wrote:
> From: Michal Wilczynski <michal.wilczynski@intel.com>
> 
> New driver specific parameter 'tx_scheduling_layers' was introduced.
> Describe parameter in the documentation.
> 
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Hi,

I'm not expert here,
but this seems to cause a splat when building documentation.

.../ice.rst:70: WARNING: Unexpected indentation.
.../ice.rst:25: WARNING: Error parsing content block for the "list-table" directive: uniform two-level bullet list expected, but row 2 does not contain the same number of items as row 1 (3 vs 4).

.. list-table:: Driver-specific parameters implemented
   :widths: 5 5 5 85

   * - Name
     - Type
     - Mode
     - Description
   * - ``tx_scheduling_layers``
     - u8
     - permanent
       The ice hardware uses hierarchical scheduling for Tx with a fixed
       number of layers in the scheduling tree. Root node is representing a
       port, while all the leaves represents the queues. This way of
       configuring Tx scheduler allows features like DCB or devlink-rate
       (documented below) for fine-grained configuration how much BW is given
       to any given queue or group of queues, as scheduling parameters can be
       configured at any given layer of the tree. By default 9-layer tree
       topology was deemed best for most workloads, as it gives optimal
       performance to configurability ratio. However for some specific cases,
       this might not be the case. A great example would be sending traffic to
       queues that is not a multiple of 8. Since in 9-layer topology maximum
       number of children is limited to 8, the 9th queue has a different parent
       than the rest, and it's given more BW credits. This causes a problem
       when the system is sending traffic to 9 queues:

       | tx_queue_0_packets: 24163396
       | tx_queue_1_packets: 24164623
       | tx_queue_2_packets: 24163188
       | tx_queue_3_packets: 24163701
       | tx_queue_4_packets: 24163683
       | tx_queue_5_packets: 24164668
       | tx_queue_6_packets: 23327200
       | tx_queue_7_packets: 24163853
       | tx_queue_8_packets: 91101417 < Too much traffic is sent to 9th

       Sometimes this might be a big concern, so the idea is to empower the
       user to switch to 5-layer topology, enabling performance gains but
       sacrificing configurability for features like DCB and devlink-rate.

       This parameter gives user flexibility to choose the 5-layer transmit
       scheduler topology. After switching parameter reboot is required for
       the feature to start working.

       User could choose 9 (the default) or 5 as a value of parameter, e.g.:
       $ devlink dev param set pci/0000:16:00.0 name tx_scheduling_layers
         value 5 cmode permanent

       And verify that value has been set:
       $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers

