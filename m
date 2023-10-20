Return-Path: <netdev+bounces-42839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D7D7D05F3
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 02:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10908282361
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 00:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF370389;
	Fri, 20 Oct 2023 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shrjz2sm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C7377
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 00:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA34C433C8;
	Fri, 20 Oct 2023 00:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697762942;
	bh=rnIfb+GILZTA3JjJg2XMTMZwzlS5SD40Q5GFiOgP0Xs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=shrjz2sm8lLpVjNejlun0cxC1rHqHaC0uGar4sDgHDRTSvQ98EZj2fujtTc1nQvdx
	 aT5n7VC3/dthkSekKnpf/J29kDlb4fF+O8U7Kl/4yQoT/sImJQhLQHAztB1anyCQb5
	 h+iDsFoDScABwem01RGzHiXutOIVV3eeiwJIH2y9eUXDKU6Vp7OHgQMV3LmKZnpy0/
	 RVe8sLPpYQwf7WYBaKuiUyzjTh4fenvRRZPAsIvIW5yfxIoSN67FXXzJp9T6tXwvY2
	 PlQ9qYIj5SemyZXAxOXW+l6QM20NSIxlCc5lPl8NYkButCPXGZRDTIJ3yLaQ7wsl/C
	 M0a6Suymegh1g==
Date: Thu, 19 Oct 2023 17:49:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Greenwalt <paul.greenwalt@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 andrew@lunn.ch, horms@kernel.org, anthony.l.nguyen@intel.com, Pawel
 Chmielewski <pawel.chmielewski@intel.com>
Subject: Re: [PATCH net-next v5 0/6] ice: Add basic E830 support
Message-ID: <20231019174900.29d93b3d@kernel.org>
In-Reply-To: <20231018231643.2356-1-paul.greenwalt@intel.com>
References: <20231018231643.2356-1-paul.greenwalt@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 19:16:37 -0400 Paul Greenwalt wrote:
> This is an initial patchset adding the basic support for E830. E830 is
> the 200G ethernet controller family that is a follow on to the E810 100G
> family. The series adds new devices IDs, a new MAC type, several registers
> and a support for new link speeds. As the new devices use another version
> of ice_aqc_get_link_status_data admin command, the driver should use
> different buffer length for this AQ command when loaded on E830.

Please make sure to mark purely Intel driver patch sets as iwl-next
rather than net-next.
-- 
pw-bot: awaiting-upstream

