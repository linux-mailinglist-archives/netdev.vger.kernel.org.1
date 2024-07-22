Return-Path: <netdev+bounces-112445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A713F939171
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 17:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0261F2209F
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 15:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA54D16DC3A;
	Mon, 22 Jul 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IraDZLWa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866231F954
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661030; cv=none; b=OYQ88no03xpGWvRpd/BK8cwX24NvsODY74CLOmYlfxiPiQtpDfzHythZHY6UI7em685Y9ViM2SnYxD4Jebb01q486UisMVMqHbiwweJcnlHxfVt2ImW3p2FRalZbOmYpujy4X+AEkonuUwfLyl4r/RKoZ9eyoAjm52QbuAuXnXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661030; c=relaxed/simple;
	bh=96SKCm9hLa8Y4hSd6fuv/NVvVYKc1Vvns31N7ZLml68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjKqdDWvZBpN8vz/UhNdHkjGJpQb7YUZvgGc7oSidt/dKyfEuK+gSjNS328Sc9JswYtS2FrReTjYxj0SRdm5qfvRtw4HKVfQ77mpcizfEqNmQ2+otfL3mty9jR/UK0jJ22c8TNPVMkd9FKagdacILUGY2VH1EmEB41U7VW9m2qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IraDZLWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDDAC116B1;
	Mon, 22 Jul 2024 15:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721661030;
	bh=96SKCm9hLa8Y4hSd6fuv/NVvVYKc1Vvns31N7ZLml68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IraDZLWaNwLijDWTMQ/Wy/zuLMeLRslSAditGmIZMpYriC2csOQdctZ2AYS4cSWEw
	 jIs/zrHR6RTgxFSImf8t9BiDiQKNq7zJUoNSB20k9wmIA1A/hSKLJnzdDbS8HLPqFO
	 kVB86Abtee7wJsO68zn3rgdTmFFbQc24eoXLqz2p5ImzzxFDhlWUV6/PIjLeoduhLT
	 amFvDYOCCfPlX9Uwhgz04kWAlqhr/Zz6HlvpaM52u9KxmpCTnUGFRpOi9x/mOCCqod
	 fxGJh3fx1j1K+3LfDfX92il/8wKDoQMGxtyBcbu7NJ1AylQkiAFCTJe3/2ygo11ZFf
	 I5BMTAYvnR5UA==
Date: Mon, 22 Jul 2024 16:10:26 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next v3 09/13] virtchnl: support raw packet in
 protocol header
Message-ID: <20240722151026.GQ715661@kernel.org>
References: <20240710204015.124233-1-ahmed.zaki@intel.com>
 <20240710204015.124233-10-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710204015.124233-10-ahmed.zaki@intel.com>

On Wed, Jul 10, 2024 at 02:40:11PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> The patch extends existing virtchnl_proto_hdrs structure to allow VF
> to pass a pair of buffers as packet data and mask that describe
> a match pattern of a filter rule. Then the kernel PF driver is requested
> to parse the pair of buffer and figure out low level hardware metadata
> (ptype, profile, field vector.. ) to program the expected FDIR or RSS
> rules.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


