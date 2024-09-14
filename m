Return-Path: <netdev+bounces-128283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF66C978D46
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 06:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4E7287B28
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 04:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D8117BD6;
	Sat, 14 Sep 2024 04:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R53AFevS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B944A14F90;
	Sat, 14 Sep 2024 04:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726287995; cv=none; b=VZ3q0k9rUVeLPWSAef6chxFEhEgRbsEYJLq2TkGTLXT4aZW+IaeW0lxugAlBpmm5JF8YnY04OZV3Hqi2KO9LX4q55rYZ1i7bfVZ8lKAbPisVyOmAfiuaXTGFbcx9rirBioalwO2eAWQ8ymgUrKcU9Zo/PE57C3WdfyfCwieRfu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726287995; c=relaxed/simple;
	bh=uWmpgmx8ElKDY7r+PbUD4ysn9NKB7N3en+sWmM4oZBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6lKLWYFt8RstWcI7iKLuuR8APkPRDVMA/snEuZrOLHIzSExz435IvF5IKlMt4e4vG+h1jYAi1mh3YdJcDChSxkwagnSTNuNq6o6ZCm8h+k5CeJE7+EJ5t8LdNGLKDZ/TB/phgB2RlB/vTcs7KNLj6yPu0zPdh7xOsO26gI8h1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R53AFevS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6334C4CEC0;
	Sat, 14 Sep 2024 04:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726287995;
	bh=uWmpgmx8ElKDY7r+PbUD4ysn9NKB7N3en+sWmM4oZBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R53AFevSR/qSXCtF9xbavZqDqhHmcP0/7rImEKPaKXawAQH3poAz+1TvzF+ttTbbg
	 0l5mjcXnnInkndHVL5PRT1c5iWuX6gtlvbofXnKf8p94pP7F9bd4VixLFpBWvvlIsb
	 gZjxHlLeVDV3FJvq24HE78mfQJzO2s/HKAsvEE/7yR/ucI1i2jR+zlTGbC7w1cst8r
	 obFamgOnU52XmaqZqhqwTUGGyG09BUfmx1f8A1/hYP70lCLAbgI/tqG5SgpYRfQipY
	 POp0gE4aXznb1Iyh9jVe1smsf6zr5mg07TNFTtJ05V5L4PLlGylWlXGoOizGcFQBI9
	 /UPf/mZyTbgog==
Date: Fri, 13 Sep 2024 21:26:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <jiri@resnulli.us>,
 <edumazet@google.com>, <sgoutham@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>
Subject: Re: [net-next PATCH v3 0/4] Refactoring RVU NIC driver
Message-ID: <20240913212633.2d35773c@kernel.org>
In-Reply-To: <20240912064017.4429-1-gakula@marvell.com>
References: <20240912064017.4429-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 12:10:13 +0530 Geetha sowjanya wrote:
> These patches are part of "Introduce RVU representors" patchset. 
> https://lore.kernel.org/all/ZsdJ-w00yCI4NQ8T@nanopsycho.orion/T/
> As suggested by "Jiri Pirko", submitting as separate patchset.

Changes look good, but you also have to remove the EXPORTs.
Kernel has a general policy of not exporting functions
if there is no in-tree caller that needs the exports.
-- 
pw-bot: cr

