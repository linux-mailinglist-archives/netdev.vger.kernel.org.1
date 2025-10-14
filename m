Return-Path: <netdev+bounces-229117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A29FABD854E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4391F35079E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624B92E36E3;
	Tue, 14 Oct 2025 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvGVfstx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC8122156B;
	Tue, 14 Oct 2025 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432407; cv=none; b=gwTioLNL6IkeSnaeFwnlmITLNdzK+T+YtNKH+J7PjSHLB/qtre1v2+l1S8ZKnlTyxahwg8GO10DaWAY/eBehnANtxNWiQ/5rrPbLxrNCCaQhIDOcy/AQlSTlib/7tUdOa49zsWB+zSLYLDcpJqtj9JsAuiY114rvflk5soO6YvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432407; c=relaxed/simple;
	bh=BglI1fX5lAtexDYcV0wYMCITnFoG8WSDlSujjx0Rfcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfm7mVLEgRvnK1U/k6BewidaQkWUqZ8w8FcZaERyi1k7jdGAmxK98Slvv3Kl04wGGEI4U1CLr0/MSPPr2J3m70Yfl4//Kb1/eFvCvUKD+YXDlgWrGjlHjwD8KAjXhMgm731pb3W5mTaZGvSfvKBv9qviTCIRZcVakHuFG6ZlZIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvGVfstx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1B0C4CEE7;
	Tue, 14 Oct 2025 09:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760432406;
	bh=BglI1fX5lAtexDYcV0wYMCITnFoG8WSDlSujjx0Rfcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PvGVfstxK+sZ/nE2KfICBwunKHSMfnui+mF8V+/uX/hPOsU5VTbSdFksuVhtNUKxB
	 rMXI8atSkV64fnE/bah7CAVVNYZ3d9t0UFvDXNzAequNbcgd8VGoteAv0tZhHXE7wA
	 5G9vum77jDXDaflUz/4JAAEACByDKJcuvIglUuT5xjkQKAcCLOT1rflQ7nVEWG3I5g
	 surNgE34JKDjbpsB/VVDDMCLhzxMPwUoVEGrO3tmzFH2LwMKkRCKCFyW88+9aQe2V0
	 hO2qpwZ8CDoM9LFvOj3N9P2tU/o6SvnybclaZcZAJRiiH4NEzx/Opf/MrMQkkvQaUe
	 aCnitjPtZUJXg==
Date: Tue, 14 Oct 2025 10:00:02 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] dpll: zl3073x: Handle missing or corrupted flash
 configuration
Message-ID: <aO4RErH2NCOdMdhW@horms.kernel.org>
References: <20251008141445.841113-1-ivecera@redhat.com>
 <aOzDGT44n_ychCgK@horms.kernel.org>
 <20251013172802.6cf1901b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013172802.6cf1901b@kernel.org>

On Mon, Oct 13, 2025 at 05:28:02PM -0700, Jakub Kicinski wrote:
> On Mon, 13 Oct 2025 10:15:05 +0100 Simon Horman wrote:
> > I am unsure how much precedence there is for probing a device
> > with very limited functionality like this.
> 
> Off the top of my head some Intel and Meta drivers do it already, IIRC.

Thanks, I think that is sufficient to allay my minor doubts here.

