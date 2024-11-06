Return-Path: <netdev+bounces-142427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7FD9BF104
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 16:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C44BEB2531E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 15:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E2318FC91;
	Wed,  6 Nov 2024 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaryHrI6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B203718C03F
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905219; cv=none; b=RDs5VF4UWhjLCOk3/Ch+uTARw3F4rA22vac89CKcPX1Ny91rg6asTXzqGMnzSJMhtLYNv70MbtMMJP86t9zgFW1s7yePM5SuSnXmQbyc4wRHGk3279ZKRzSczCel7coZAWwW3TXGYRLuWzUvSyil339cO+Ow5xD5jGzlIAv7ekU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905219; c=relaxed/simple;
	bh=ZxhHGcVMGkOTmRlXHYf2j9fcy44PbxWGEr5K4E/whr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrU7+ZuXFIVZdnASfJZ3TNWfRHAysnjBoCITvuyX1XY7Q1fXu6z7OH49X5i3FbO5Lg8aTVANMAUrKi/ZfsP83AhG9uue8qvdllLg8XTFq2lW8DBb1NMBTHsjX93cyJ0S/e7Mo9DT4jZAEJxL9neEZGmxuazEd27TZKy/GEstT1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaryHrI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FEAC4CEC6;
	Wed,  6 Nov 2024 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730905218;
	bh=ZxhHGcVMGkOTmRlXHYf2j9fcy44PbxWGEr5K4E/whr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NaryHrI6t/SKwyRhRkOiIJZWKINoEtt+Q9pO4Mnts9c3ze1EBKf9KgSz2/oYegdws
	 KljaPXs2Q00MR6Ouxm8Hwy+HbaiNKnw7VIkrqNgH9NgdYgHRm01qDgGKmEqPlyZpmD
	 9H5SGhzg+Dk8/hsPnZK+G99lrnN3KSL/ff24bhW8MpstCBr5d0gBCWolQDL0dsrxs7
	 JEcfdaWp20Ow3+myi2l9umKlGs03m9i7b6oJrT++XLtCn98gsmfvWAmVH2HDzM6VGC
	 pxQtf+MkSae7dvAqH/aRrYxFu8v6na+uHweNEbbNAMQYAdrFM9463hbpTeC/1ub/Xy
	 9pYXeyMG/KDAw==
Date: Wed, 6 Nov 2024 15:00:15 +0000
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, david.m.ertman@intel.com,
	netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: change q_index variable
 type to s16 to store -1 value
Message-ID: <20241106150015.GQ4507@kernel.org>
References: <20241028165922.7188-1-mateusz.polchlopek@intel.com>
 <20241102143818.GM1838431@kernel.org>
 <748c0685-cd16-4f7e-b359-91b095fc3d26@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <748c0685-cd16-4f7e-b359-91b095fc3d26@intel.com>

On Mon, Nov 04, 2024 at 01:56:20PM +0100, Mateusz Polchlopek wrote:
> 
> 
> On 11/2/2024 3:38 PM, Simon Horman wrote:
> > On Mon, Oct 28, 2024 at 12:59:22PM -0400, Mateusz Polchlopek wrote:
> > > Fix Flow Director not allowing to re-map traffic to 0th queue when action
> > > is configured to drop (and vice versa).
> > > 
> > > The current implementation of ethtool callback in the ice driver forbids
> > > change Flow Director action from 0 to -1 and from -1 to 0 with an error,
> > > e.g:
> > > 
> > >   # ethtool -U eth2 flow-type tcp4 src-ip 1.1.1.1 loc 1 action 0
> > >   # ethtool -U eth2 flow-type tcp4 src-ip 1.1.1.1 loc 1 action -1
> > >   rmgr: Cannot insert RX class rule: Invalid argument
> > > 
> > > We set the value of `u16 q_index = 0` at the beginning of the function
> > > ice_set_fdir_input_set(). In case of "drop traffic" action (which is
> > > equal to -1 in ethtool) we store the 0 value. Later, when want to change
> > > traffic rule to redirect to queue with index 0 it returns an error
> > > caused by duplicate found.
> > > 
> > > Fix this behaviour by change of the type of field `q_index` from u16 to s16
> > > in `struct ice_fdir_fltr`. This allows to store -1 in the field in case
> > > of "drop traffic" action. What is more, change the variable type in the
> > > function ice_set_fdir_input_set() and assign at the beginning the new
> > > `#define ICE_FDIR_NO_QUEUE_IDX` which is -1. Later, if the action is set
> > > to another value (point specific queue index) the variable value is
> > > overwritten in the function.
> > > 
> > > Fixes: cac2a27cd9ab ("ice: Support IPv4 Flow Director filters")
> > > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > > Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> > 
> > This looks good, although I am interested to know what the maximum value
> > for q_index is. And, considering unsigned values are used elsewhere, if
> > using 0xffff within this driver was considered instead of -1.
> > 
> > That notwithstanding,
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Hi Simon!
> 
> Thanks for Your review.
> What is about q_index: it stores queue index which can be theoretically
> up to few thousands. So in this case s16 should be enough and will be
> able to hold all indexes. I didn't consider 0xffff as this may be
> misleading, I decided to stay with -1.

Thanks. I agree that if we are expecting the maximum (positive) value
to be a few thousand, then the s16-based approach you have taken is a good
one.

