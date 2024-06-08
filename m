Return-Path: <netdev+bounces-102012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F72901187
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 14:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD49282840
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 12:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C311779B8;
	Sat,  8 Jun 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZSmXmWn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FBB15DBA3
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717851416; cv=none; b=RSC+OM8RLXtdwMEeOMZ8KhR3sVHaC1RohNpoMshTqqivqIT0xhb92EDBrfjYwsNg7T8EfBoyRNiJGfYCi+Ul/ih53vmGK4QhfkU1Ya49Hy9Ogxhq4qfFmjd08GWWCiI8QAL+taeLSwDD7euVzFCdnif/ZfLp8c/8hP5fPkmJwck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717851416; c=relaxed/simple;
	bh=HZknWNSIIncSkXQCPrlGguunTHGTQQfSZWo9fAXhlSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2VObGdgRx6F0ZChlbJcyq9VHpsPlTOnohGFGOiNeIQ0i3ApID3zjfoF1DAgGsn5X81O+P043G5hFx81Hwewv1UrYsLLGsda2UpHvKqj9fPelQ9p7QNbzSuYQ/cSxWotFEjxVKuNXDo2vIGbyMA3A4DZyv3yJGAnw0cGTV1EQ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZSmXmWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1E3C2BD11;
	Sat,  8 Jun 2024 12:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717851416;
	bh=HZknWNSIIncSkXQCPrlGguunTHGTQQfSZWo9fAXhlSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZSmXmWnf51RLe/wQY5EgMdlffbRhhtasVaV4kMHa1iyhVP8PS0p1ikfpBdvBe7yW
	 CG4bspL/MC0qF13wnieGpoClvpHIIw6w5jnwaIZDvPhxA6Bg2hu6m3aiFKwy76QnxT
	 quD5mbRn00NCK0mYI6NRd2FnrDmCsfdbzRPeHfez7nShKNaei0fVwyi2pZwDFsjey2
	 MSTmdOqkXS8V0h47N5iaZcc/qCGqiNvS1D97EUsVQddHJzu0MV8RH+7Ph6PMCzKsZh
	 Po0pDTOqC7E3kcCfHbxEEpg66wA8RJvcRZWJYcjQBtVUeRPd+20W1HxDtQvKfe+DkM
	 zly6FgXGttJxg==
Date: Sat, 8 Jun 2024 13:56:53 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Simei Su <simei.su@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 02/12] ice: support Rx
 timestamp on flex descriptor
Message-ID: <20240608125653.GU27689@kernel.org>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-3-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604131400.13655-3-mateusz.polchlopek@intel.com>

On Tue, Jun 04, 2024 at 09:13:50AM -0400, Mateusz Polchlopek wrote:
> From: Simei Su <simei.su@intel.com>
> 
> To support Rx timestamp offload, VIRTCHNL_OP_1588_PTP_CAPS is sent by
> the VF to request PTP capability and responded by the PF what capability
> is enabled for that VF.
> 
> Hardware captures timestamps which contain only 32 bits of nominal
> nanoseconds, as opposed to the 64bit timestamps that the stack expects.
> To convert 32b to 64b, we need a current PHC time.
> VIRTCHNL_OP_1588_PTP_GET_TIME is sent by the VF and responded by the
> PF with the current PHC time.
> 
> Signed-off-by: Simei Su <simei.su@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


