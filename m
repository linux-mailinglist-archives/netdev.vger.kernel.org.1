Return-Path: <netdev+bounces-145461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D619CF8F1
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC7D2899D2
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 22:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4E61FB73D;
	Fri, 15 Nov 2024 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSAMZih3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834EE1F893A;
	Fri, 15 Nov 2024 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706120; cv=none; b=I7iUi2ivFyU8tRV1mhSUVoB/VnLbCCjW46IeAhAvZCXJi3WNmsQ0LGZYzQ84qylh59nHBou9AIbQTCCrbd100Km6dCId5mobrfiS7yLUvgrdlUJ05+xJQ07gJybLPvL7QrQbTiE4pAjewXLqGNnt3+lDPSg8jTMa4hKotNuZ0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706120; c=relaxed/simple;
	bh=k0g3XUmKfL/FbjKfmQsN2e0noC2xG7BjO+ZZ6ZxxaYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uaeF/yhvb7M/5WYGJtbIjJqKh7ZxpH22+feKFCzG0ZiiwtkhZTPq3BDZBYsP6SrOEAtj/4dNXR0ZJS/Ait6xcSBx8m0Q1fYNmDL2wLltjleDyjKdiq36EASY37BnNGhY4SL/EnvKtkO8qbZ2U+ufQklGqeBMbtd8facjY22rpqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSAMZih3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1546C4CECF;
	Fri, 15 Nov 2024 21:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731706120;
	bh=k0g3XUmKfL/FbjKfmQsN2e0noC2xG7BjO+ZZ6ZxxaYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eSAMZih3WrbJDKa91wE1x0mTR4CJb93inDYru65VHrV4YpQAVeh2ZMsA5ngJWvmxV
	 jP422dsvR25DkDoLrgqOoS29e+Cb3pBIU7pBlC8MvVQVneS9GJCZDvbQlQUVB3HWe0
	 fayaL9ASXWPIzY41p3wrJhZxHxJWcDc3RnhbKyyi4Dq0Q6HS7qKctqFCE13aj4kTqa
	 Cu0Ja9ap37zG2e8nUHhvqXQNAnpvxSCxIihBpLNMCdj9LCkrihaBkyQ88WtIOydJOd
	 FoPg/ZIlw5rwQRp8ixB217bfcIYfle2VOIVV58oL6NVa4TP+lbPcJ0zfgBorj2LGva
	 6cbxOxWGGKSqg==
Date: Fri, 15 Nov 2024 13:28:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 donald.hunter@gmail.com, horms@kernel.org, corbet@lwn.net,
 andrew+netdev@lunn.ch, kory.maincent@bootlin.com
Subject: Re: [PATCH net-next v2 8/8] ethtool: regenerate uapi header from
 the spec
Message-ID: <20241115132838.1d13557c@kernel.org>
In-Reply-To: <20241115193646.1340825-9-sdf@fomichev.me>
References: <20241115193646.1340825-1-sdf@fomichev.me>
	<20241115193646.1340825-9-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 11:36:46 -0800 Stanislav Fomichev wrote:
> +/**
> + * enum ethtool_header_flags
> + * @ETHTOOL_FLAG_COMPACT_BITSETS: use compact bitsets in reply
> + * @ETHTOOL_FLAG_OMIT_REPLY: provide optional reply for SET or ACT requests
> + * @ETHTOOL_FLAG_STATS: request statistics, if supported by the driver
> + */

Looks like we need a doc on the enum itself here:

include/uapi/linux/ethtool_netlink_generated.h:23: warning: missing initial short description on line:
 * enum ethtool_header_flags

