Return-Path: <netdev+bounces-26005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C824A7766AD
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 19:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB85E281B8F
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 17:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7680A1D2FF;
	Wed,  9 Aug 2023 17:46:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5051CA1C
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 17:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAD8C433C8;
	Wed,  9 Aug 2023 17:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691603191;
	bh=+h95Egn4FLPJwtzkMsZtjRU5YQ/9jgcffANX0lizmvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KxDlBdS1kdFQN6wqcING9qSR3RK1O+2BnmK1SdosMJbnEq6R3BA7LWsYCVlscfcZR
	 a0OzwKHpDbXVRPmdOExD1ZWL6MCh3WPur3YVhSrTG/o/5qPDU5Hr1Cujxf/p/kg9vi
	 cjpCAEsEHF2shDsqWC2ophNEOreL4TFDsesyheivBsTjWaNfK7xChz0ObG0kV6KZyn
	 XfUKUhjSNAeZ7DS0YNDHTkFRJalRnL5t3a21DB2FAne7lI9Q0EEIPLfy4wXyfny1PP
	 OTIzMffZ0NYyCXtKQHjgLcKnFNPBhbPJdarzF/ONZATpNVyciSvphHmc9Te9uzvcae
	 +qtnm3XEMPLaw==
Date: Wed, 9 Aug 2023 19:46:27 +0200
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH iwl-next v4 0/3] ice: split ice_aq_wait_for_event() func
 into two
Message-ID: <ZNPQ83upTXd+fTg5@vergenet.net>
References: <20230808215417.117910-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808215417.117910-1-przemyslaw.kitszel@intel.com>

On Tue, Aug 08, 2023 at 05:54:14PM -0400, Przemek Kitszel wrote:
> Mitigate race between registering on wait list and receiving
> AQ Response from FW.
> 
> The first patch fixes bound check to be more inclusive;
> the second one refactors code to make the third one smaller,
> which is an actual fix for the race.
> 
> Thanks Simon Horman for pushing into split, it's easier to follow now.
> 
> v4: remove excessive newlines, thanks Tony for catching this up
> v3: split into 3 commits
> 
> Przemek Kitszel (3):
>   ice: ice_aq_check_events: fix off-by-one check when filling buffer
>   ice: embed &ice_rq_event_info event into struct ice_aq_task
>   ice: split ice_aq_wait_for_event() func into two

Thanks for the split :)

Reviewed-by: Simon Horman <horms@kernel.org>

