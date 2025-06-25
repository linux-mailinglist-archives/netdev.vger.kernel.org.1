Return-Path: <netdev+bounces-201083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A9AAE8093
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A451C5A0072
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B902289347;
	Wed, 25 Jun 2025 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwkqAs80"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577941EA7EC
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849708; cv=none; b=X3mriShEHNUVFl1Z57Efdk4rpCGW3041+yEN89DYL4Z3mVFD/yT8Gh08mCetmdjbUMY8FEDIKeBSg1Jp+kQCdCuGpFpaTszz2EHHL8PZ120UC3nUd3pcjMWN+iEy5hXJ2Z+v/fpIHHRAjKOC4wRg8ckMZ5HKseluNU0zLcg3mik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849708; c=relaxed/simple;
	bh=xcidaHPfMLvMJlf+ToEJja75Bos8Nz1FFdvWyrC4HT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojs9tk0xoKG1kH2IEjKeMB0HqpYzqoFhThMnSdd0bY2D7f1NpsczmjXSgIYVH33rXojllpIBDel1PskEv8z73ewJ9gmU475XIL73zvRnq28fhcTtccue3t/WvRASwwz+jTremmLI7YvnwoCYGqbHMKWH3kFn1fph4MIQ93EGXQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwkqAs80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58564C4CEEA;
	Wed, 25 Jun 2025 11:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750849707;
	bh=xcidaHPfMLvMJlf+ToEJja75Bos8Nz1FFdvWyrC4HT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwkqAs801h6B/b0wvHxdSNqxLH7uT/qUy/kwHMtNClBazIkb7ZrcGHEir6b+H7Kq7
	 vgOcPN05TUL6qOvvQYbSqto/l7r94LDAEvTkJHCHByGUcfgnV5VxukZXnvck/D4DiL
	 OG5ITmJHbs6JeM8uVFj6WieJ1ACSJjCl+pP7iku7e4us8G+bMGrC6NdmShLYsNTULO
	 jYIvvHLiP3uOVKysZAXT2aNUKKefifoW8KDvrOnPnlz727IkyDGm9sisI9eqJYyI/D
	 P7cBRP0Pzd/jatdlx5Uo07xSt4HGPOtXBfNJQ7gHYbQM/zFsdivC85L6jxh0migei1
	 RZyey6S8Q1x9A==
Date: Wed, 25 Jun 2025 12:08:24 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, alexanderduyck@fb.com,
	mohsin.bashr@gmail.com
Subject: Re: [PATCH net-next 5/5] eth: fbnic: rename fbnic_fw_clear_cmpl to
 fbnic_mbx_clear_cmpl
Message-ID: <20250625110824.GA1562@horms.kernel.org>
References: <20250624142834.3275164-1-kuba@kernel.org>
 <20250624142834.3275164-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624142834.3275164-6-kuba@kernel.org>

On Tue, Jun 24, 2025 at 07:28:34AM -0700, Jakub Kicinski wrote:
> fbnic_fw_clear_cmpl() does the inverse of fbnic_mbx_set_cmpl().
> It removes the completion from the mailbox table.
> It also calls fbnic_mbx_set_cmpl_slot() internally.
> It should have fbnic_mbx prefix, not fbnic_fw.
> I'm not very clear on what the distinction is between the two
> prefixes but the matching "set" and "clear" functions should
> use the same prefix.
> 
> While at it move the "clear" function closer to the "set".
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


