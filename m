Return-Path: <netdev+bounces-56323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF39780E87A
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A537B1F213FD
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D37359167;
	Tue, 12 Dec 2023 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGN8bY1X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004155914D
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 10:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36339C433C7;
	Tue, 12 Dec 2023 10:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702375282;
	bh=xB0XC5NParDMdJCBHxBgpR5zJlLTnRVrgWYfP+1E7KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cGN8bY1XZ6SbddqG1hJFxctwloZFsJVbK6lryQAJ47Vigg6gHAO56IU4BMvda6oWb
	 RZ2j1q460uQAU7UJoV1CphJGj7vt18qwKUbwhbYqj9AinHss3RRxSbldr6jH0vD5xA
	 3EWjBejReIIVca5wE5XSN5eSi/Bcw9xJ/F9xO7KQNfxPuOH5TRu9IHiBeAZVjJk/B7
	 FCc2RSk0eXbR1QDkHocTQGODHaUGGodxAJsTs7Fsm0V7BEW7i2EIapuyYt5MGNwNEH
	 Wlh+EMkGJkULbpz7nvjXN67ViGO+hCWG3FWdH31szRByEeGfGC7JDrdqs4zaVL/Fvo
	 bjJjvkgUNVD4g==
Date: Tue, 12 Dec 2023 10:01:18 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jan Glaza <jan.glaza@intel.com>,
	Michal Michalik <michal.michalik@intel.com>
Subject: Re: [PATCH iwl-next v1 1/3] ice: introduce new E825C devices family
Message-ID: <20231212100118.GU5817@kernel.org>
References: <20231206192919.3826128-1-grzegorz.nitka@intel.com>
 <20231206192919.3826128-2-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206192919.3826128-2-grzegorz.nitka@intel.com>

On Wed, Dec 06, 2023 at 08:29:17PM +0100, Grzegorz Nitka wrote:
> Introduce new Intel Ethernet E825C family devices.
> Add new PCI device IDs which are going to be supported by the
> driver:
> - 579C: Intel(R) Ethernet Connection E825-C for backplane
> - 579D: Intel(R) Ethernet Connection E825-C for QSFP
> - 579E: Intel(R) Ethernet Connection E825-C for SFP
> - 579F: Intel(R) Ethernet Connection E825-C for SGMII
> 
> Add helper function ice_is_e825c() to verify if the running device
> belongs to E825C family.
> 
> Co-developed-by: Jan Glaza <jan.glaza@intel.com>
> Signed-off-by: Jan Glaza <jan.glaza@intel.com>
> Co-developed-by: Michal Michalik <michal.michalik@intel.com>
> Signed-off-by: Michal Michalik <michal.michalik@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


