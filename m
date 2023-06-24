Return-Path: <netdev+bounces-13768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF77D73CD5B
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 00:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35571C208F2
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB59EAFE;
	Sat, 24 Jun 2023 22:59:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC9FD521
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 22:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B90BC433C8;
	Sat, 24 Jun 2023 22:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687647588;
	bh=V+gNb2uNPHlmhZbm6qx0eti88OFU//vFkN1Kk1bGWBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=luFD2AG045S3VLKuq/PvQt5WeHmja152ItWptSxTg1Yj18qs1lKXc8KG8BfQX1IYA
	 UsoBD6RzX+CpV75w2KldA5hJqomMkwPW6XA4k7gBp+G/6Vh08bddU3NCssBgurW3KQ
	 QoTB7T8OeKrF8nLSuRTVyE0jOxdiiAjuc2l2PtdrZBEwFRtyFB7OrW9/MOqp3M1RNh
	 15Nojc7vdi/u6RW/cvlUi5bbcHMwe5GJFggDiu3mqhutlZZ2dBEQiamnqBsOUVjoRC
	 JdyoSHvTqO79P8PPEtNf4fO0Wlk4fG5CFre8YZnK/wHZ4E59Ci8uizSjXTdhNTqKfT
	 vAELM7gvaVtIA==
Date: Sat, 24 Jun 2023 15:59:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: davem@davemloft.net, pabeni@redhat.com, alex.aring@gmail.com,
 stefan@datenfreihafen.org, netdev@vger.kernel.org,
 linux-wpan@vger.kernel.org
Subject: Re: pull-request: ieee802154 for net-next 2023-06-23
Message-ID: <20230624155947.1b94903e@kernel.org>
In-Reply-To: <20230623195506.40b87b5f@xps-13>
References: <20230623195506.40b87b5f@xps-13>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jun 2023 19:55:06 +0200 Miquel Raynal wrote:
> As you know, we are trying to build a wpan maintainers group so here is
> my first ieee802154 pull-request for your *net-next* tree.

Pulled thanks!

In the future, please try to avoid merging in tags from Linus's tree
directly. You can send a PR to net-next and fast forward, that results
in a more straightforward shape of the history, and avoids getting 
the back-merging wrong (Linus said a couple of times that any cross-
-merge must have an explanation in the commit message, for example).

