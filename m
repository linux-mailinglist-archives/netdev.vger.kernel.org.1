Return-Path: <netdev+bounces-29843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98167784E7F
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 04:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721DF1C20C0B
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 02:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E531710E9;
	Wed, 23 Aug 2023 02:03:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935F715A4
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 02:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3148C433C8;
	Wed, 23 Aug 2023 02:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692756225;
	bh=yFN0cQpMIat5ayx3g1CsZp0uk9eYWA06wwCrpsWjxkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HA/TtqL3GIQBKA7JOLGo1omaxrH2T1Arg85bX+NFA/N6Td5PfOlpYXOOpLWo2uB4e
	 qawm2VOGr6UZMLKYNSZ9M6m96F8WxQDmK22v9CAs2Lb6hwh+Ja++Hu2M4uYmJvLgsH
	 mY6ECkznlMjexF/ixxe3uPGfIItushnEIl1CPGhctjCxMGX5IdG09B4aryN5emdszc
	 WmKMPw8WjEXwmZNg6zGEMNP1ahF2Dk0XHnOD1GeikGJmZxpgqWsr8wX7XfoiVJLjht
	 fO7pOsGjXY++oOyzpv0+I6PhZ60VWEjqgpKs7+iriIHe4aw4n0x/Rpz48Ildu+BB3m
	 V32cTGKAE4Psw==
Date: Tue, 22 Aug 2023 19:03:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Stanislav Fomichev
 <sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 00/12] tools/net/ynl: Add support for
 netlink-raw families
Message-ID: <20230822190343.3e780afb@kernel.org>
In-Reply-To: <20230822194304.87488-1-donald.hunter@gmail.com>
References: <20230822194304.87488-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Aug 2023 20:42:52 +0100 Donald Hunter wrote:
> The netlink-raw schema is very similar to genetlink-legacy and I thought
> about making the changes there and symlinking to it. On balance I
> thought that might be problematic for accurate schema validation.
> 
> rtnetlink doesn't seem to fit into unified or directional message
> enumeration models. It seems like an 'explicit' model would be useful,
> to force the schema author to specify the message ids directly.
> 
> There is not yet support for notifications because ynl currently doesn't
> support defining 'event' properties on a 'do' operation. The message ids
> are shared so ops need to be both sync and async. I plan to look at this
> in a future patch.
> 
> The link and route messages contain different nested attributes
> dependent on the type of link or route. Decoding these will need some
> kind of attr-space selection that uses the value of another attribute as
> the selector key. These nested attributes have been left with type
> 'binary' for now.

Looks good, thanks!

