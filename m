Return-Path: <netdev+bounces-23860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E0C76DE39
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658591C2143B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9A86D1B;
	Thu,  3 Aug 2023 02:28:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC8263C6
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4F7C433C8;
	Thu,  3 Aug 2023 02:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691029708;
	bh=FXTbCOtpzqEtg7/Hp4beVHozA7mFfXL0qrmn1JFW1Os=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ey+F6cMJL70yF3u6tqN4pr1K0xl/7UpaLlcgrQ7U8HOnBaAbi9sHTr3rWGw4/XdX+
	 P+KY8/IC3QBzhOyXCNSFmGotFdIvtLPFGt/N0hCvDCrKj2JZu4Zbt38sbHq8npQWQw
	 W5mQkoy4fF61L3sX7GN5X7U235JJK+VMZGP/CrxncJa99Px+ks6pISMku6tGlc/P9F
	 qmlv4iz6Kn1Hc09YAzS5n8FgWQPfac9A3GLgTptqIu3mKAQWpM2oPBmGGW1MbwVY0b
	 xYcReu7Cy+e6SABmCq4WJbi2++jQRw2ADGGU9OX7eg0nuKn+L9zIpaTniZQzxbVvT0
	 j2UudJE5qJ8iQ==
Date: Wed, 2 Aug 2023 19:28:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Karol Kolacinski <karol.kolacinski@intel.com>,
 Michal Michalik <michal.michalik@intel.com>, Jan Sokolowski
 <jan.sokolowski@intel.com>, Pucha Himasekhar Reddy
 <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next 5/7] ice: Add get C827 PHY index function
Message-ID: <20230802192827.6fdf36ae@kernel.org>
In-Reply-To: <20230801173112.3625977-6-anthony.l.nguyen@intel.com>
References: <20230801173112.3625977-1-anthony.l.nguyen@intel.com>
	<20230801173112.3625977-6-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Aug 2023 10:31:10 -0700 Tony Nguyen wrote:
> +bool ice_is_pf_c827(struct ice_hw *hw);
>  int ice_init_hw(struct ice_hw *hw);
>  void ice_deinit_hw(struct ice_hw *hw);
>  int ice_check_reset(struct ice_hw *hw);
> @@ -94,6 +95,10 @@ ice_aq_get_phy_caps(struct ice_port_info *pi, bool qual_mods, u8 report_mode,
>  		    struct ice_aqc_get_phy_caps_data *caps,
>  		    struct ice_sq_cd *cd);
>  int
> +ice_aq_get_netlist_node(struct ice_hw *hw, struct ice_aqc_get_link_topo *cmd,
> +			u8 *node_part_number, u16 *node_handle);

doesn't seem like this one needs to be declared in the header?

> +bool ice_is_pf_c827(struct ice_hw *hw);

and this one is declared twice

