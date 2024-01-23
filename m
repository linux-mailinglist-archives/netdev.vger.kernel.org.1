Return-Path: <netdev+bounces-65147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C34218395AB
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 18:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0846EB2F4D8
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B137F7DF;
	Tue, 23 Jan 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9c+ekZY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00EA81AA5
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028726; cv=none; b=oJaucCJDIn+e6QJAIHvLRgpu1+8zxDCsZCeSQGIgRV+IL0YpYvQ6WwRcfj5/qXEvrsYbnf+WlQYq0GPdjxgMqo17iJVV4N2eieqXWrkkpiss7JpFVYYISsMlVRN5J0H2C+9PKY1VFw/fX99WFXGpWOcnRps9o2b3VlIUSw6gIT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028726; c=relaxed/simple;
	bh=/XFOUY3sTDjdatmqc3J67Iy1LW8Lxb4uwFo2mgAnqxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExTUuUpI4XzjVlj2PZtBFoA3xfXukUFkI+Ot0fNqMwsXUD0n831rvrBKpwe08evzXr3KmKvnMAeuME1K22qdh3m51UTxj+wTi0xVA48ciPuEYJXQjRX/wuZJy0tO1KXTbpOi4Tegfes6rqwYCTLghNXvsQf8eo491kM7HFJoYbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9c+ekZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C93C433F1;
	Tue, 23 Jan 2024 16:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706028726;
	bh=/XFOUY3sTDjdatmqc3J67Iy1LW8Lxb4uwFo2mgAnqxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K9c+ekZYEe+Z5rDBPfYCTslbfEdLlvx0LzFLRD3hAs0T+xFconZOe9k6Lodf1Sj2m
	 id1nYStVKBBWQPDFwjzFF2VroeZXAodMN+s1PHHpEeZv49keFkkxNvN+r6anzpiXvl
	 33Ftdwq5jf9/zY2bfHXPFc/MdLrhPpbGoP3aLQ7JFvS1DwZlsUjkRowRUU5hFGGxS1
	 hllCCImUAnHaiEv41NyAtaF3Kg9kFDBzzTeRV80NLTMKLYtxF3X31QilnSQ6tdd2Du
	 KHEKiYsJGpo9mcBoy5tBa8IluYlP3llpxNVHO8oECzfcynrrVhTedOJh78Qbg+FKnZ
	 lZHA+nJD+aVPA==
Date: Tue, 23 Jan 2024 16:52:02 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v7 iwl-next 4/7] ice: don't check has_ready_bitmap in
 E810 functions
Message-ID: <20240123165202.GJ254773@kernel.org>
References: <20240123105131.2842935-1-karol.kolacinski@intel.com>
 <20240123105131.2842935-5-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123105131.2842935-5-karol.kolacinski@intel.com>

On Tue, Jan 23, 2024 at 11:51:28AM +0100, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> E810 hardware does not have a Tx timestamp ready bitmap. Don't check
> has_ready_bitmap in E810-specific functions.
> Add has_ready_bitmap check in ice_ptp_process_tx_tstamp() to stop
> relying on the fact that ice_get_phy_tx_tstamp_ready() returns all 1s.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


