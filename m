Return-Path: <netdev+bounces-172440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B648A54A5C
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 13:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A10162046
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA30220A5C1;
	Thu,  6 Mar 2025 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taQlrreE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B79201022
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262965; cv=none; b=gGQpqWnOLJ2MtTegOhn3W/1ne+8K1bGpxCxqfv/cYnO9iLJLw/hmeLEyLRkJVSGL4w2eIO2AEEDxI0tIP9P271UrlQtyqwf6TAlomVd83X5VOxZYad2obLMiM92HNf9agAr1mv3Eg7d/J8W6QBk+b/QCrO+7KcTk9T78YA9NgqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262965; c=relaxed/simple;
	bh=JO3TcKcDpOeVU8o4ZGGVe8L1215+8eknf+DBnqkUTeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqmvAxf/4U/Z2GDkKXOrQ27YGecpoo/ZJir9jcy9NOhfOUXnjqbHWokxGibt7mCgb/G4MdmHwz6SO41oXErNAhe9qIhwf016eiCBclGMn3vDOSQkx3nhGuHg4Cm5wKhN1Kr3aIPwInBY6uZLNgqAhuKTkr9XfVvL6VBq6DHVoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taQlrreE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FC4C4CEE0;
	Thu,  6 Mar 2025 12:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741262965;
	bh=JO3TcKcDpOeVU8o4ZGGVe8L1215+8eknf+DBnqkUTeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=taQlrreEQdyxB4oZM4Mite4raqVI8+0U2d26gtinRe5qQE0HNpEDkakitfMSuxJmz
	 1xgkT2l7QJjuu23F2MFeU9jCUrVDnBp9BvGd/RAGvLUO7CypXuvAzwLt8Vj+RoJ1kn
	 POmi5dRGuSxprDiFGJiO60Wgp7HbBlU6q0oWmVXGn57kpq3Tr18jQ7RO0zfyDtmxsA
	 tb/varSABvFXttoqjV6wKtUYuZ5IsHhPl2K1HOl8kFhPZrQj3f8DC9yL5cfCtYHMb0
	 fMByZBKm6Kk3Z53Iild6GHyYMjCtWSWPM9KQ0jUKEo+0GWjwDbY+sujCIyMjMpc4oL
	 BnRPc0VE2IYPg==
Date: Thu, 6 Mar 2025 12:09:21 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [PATCH net-next] net: airoha: Enable TSO/Scatter Gather for LAN
 port
Message-ID: <20250306120921.GZ3666230@kernel.org>
References: <20250304-lan-enable-tso-v1-1-b398eb9976ba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-lan-enable-tso-v1-1-b398eb9976ba@kernel.org>

On Tue, Mar 04, 2025 at 04:46:40PM +0100, Lorenzo Bianconi wrote:
> Set net_device vlan_features in order to enable TSO and Scatter Gather
> for DSA user ports.
> 
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


