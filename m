Return-Path: <netdev+bounces-40704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E357C85B3
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 14:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033601C211F1
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2B114A90;
	Fri, 13 Oct 2023 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmK/sreB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8967B13FEC
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 12:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6E5C433C7;
	Fri, 13 Oct 2023 12:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697199914;
	bh=Sh3lXd+8Z4IJV4cJcY6y0VkcalEpNiJDy+Eu/kpmhQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmK/sreBKFhUnjkjBhAGs+enKTg3jMQxcTC4POByhbDaNouy3nPmtM+spFNyYVyV8
	 r3uniMQPwpyszw0OrKCCL1HvLKmj2leZEpbaFXJoWZnOiHkATS/uV3uklWHJGDaief
	 4lBt16xZni0e68JuOQlnz+XysVj6xzZai4Oa0cB7C4H8d1WPOLrr6f3QFSTZDrJsqY
	 78TOIEdCewNIYOVAWgY0ibmgNTQoj+4IlzFiJDmMWhxrXB7nsVES3ApDQvrLkWFFim
	 8rhtgOtHrHT8GLFvU14Z5LBMqp/BgqRuUcB1BVQOLYu37xfBdC3vwIyAtAeP9pfynr
	 JAlWYGNBHSBqQ==
Date: Fri, 13 Oct 2023 14:25:12 +0200
From: Simon Horman <horms@kernel.org>
To: Dave Ertman <david.m.ertman@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] ice: Fix SRIOV LAG disable on non-compliant
 aggreagate
Message-ID: <20231013122512.GJ29570@kernel.org>
References: <20231010173215.1502053-1-david.m.ertman@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010173215.1502053-1-david.m.ertman@intel.com>

On Tue, Oct 10, 2023 at 10:32:15AM -0700, Dave Ertman wrote:
> If an attribute of an aggregate interface disqualifies it from supporting
> SRIOV, the driver will unwind the SRIOV support.  Currently the driver is
> clearing the feature bit for all interfaces in the aggregate, but this is
> not allowing the other interfaces to unwind successfully on driver unload.
> 
> Only clear the feature bit for the interface that is currently unwinding.
> 
> Fixes: bf65da2eb279 ("ice: enforce interface eligibility and add messaging for SRIOV LAG")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


