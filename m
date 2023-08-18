Return-Path: <netdev+bounces-28958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 207EE781420
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 22:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5E71C2168F
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20CA1BB4A;
	Fri, 18 Aug 2023 20:10:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6299219BCC
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 20:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A4AC433C7;
	Fri, 18 Aug 2023 20:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692389413;
	bh=3WTGm9sukQldNz3/XX3Fxe7k0fT0XfvVNeBHgRsgS/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bFHH8N/ea8xvShcopNfPzR85QeJyWu/BQYfoj7Wbc7dSXQuZiLGET2ibCiKiKalVk
	 5O1Kn6lkhrHu8ItX+uII7gzwoLypc/vRXLbbm1VbC3xoo6zRdWbfwv9KAg8vmXIfy6
	 mKF0ixGJyR1dA6BKX5Nexq9rNTCFFfegyD7vpy1ZtlmZNLl4YxTBX5QDrFf5nDar19
	 f/tJEjc8BhcJf3qhyuRnODjvKe6mefUFySV2tdf+tHJO2xqSXujWsxFyW4Bke4O7qZ
	 gi8ZHEKOoeOr9+PpK3arAJMAHSgpLwHsoani5hyi9SEzfhMeiy86Yg0seZhFfIz2aP
	 GZXlbEdtbgcKA==
Date: Fri, 18 Aug 2023 13:10:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Willem de Bruijn <willemb@google.com>, Ido Schimmel <idosch@idosch.org>,
 Gal Pressman <gal@nvidia.com>, netdev-driver-reviewers@vger.kernel.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>
Subject: Re: [ANN] periodic VC call and HW-specific CI
Message-ID: <20230818131012.5e0bdcd6@kernel.org>
In-Reply-To: <20230814104632.4b0b8b95@kernel.org>
References: <20230814104632.4b0b8b95@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Aug 2023 10:46:32 -0700 Jakub Kicinski wrote:
> we had been hosting a VC call on BBB every 2 weeks to discuss current
> netdev topics, mostly on less technical topics like organizing reviews.
> Everybody is invited, if you'd like to attend please select suitable
> time in this poll:
> 
> http://whenisgood.net/ga9cbki

Alright, I think we got all the responses we'll get.

The new meeting time is Tue 8:30am Pacific time, starting Aug 29th 
and then every two weeks. VC link: https://bbb.lwn.net/b/jak-wkr-seg-hjn

