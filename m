Return-Path: <netdev+bounces-121208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C28B195C302
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 03:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6575E1F23285
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 01:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46A817997;
	Fri, 23 Aug 2024 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISKFRdnV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6FB171C2
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724378162; cv=none; b=hu4PTSyjTdqVtUClxL8X45HgOx2VKQ4GXQXzo2zOToiUFMSgX7owpgz15HaX7WFMf2BX0oMXi0ItvoV7iR2stLqJvStSjKa2hebgbojden567iCyy5+eZ1AMkbD6jwCK38Btjiy7wNkZXBhTvfrAzkW9XfwbPCTD1IHhZXXeTxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724378162; c=relaxed/simple;
	bh=puQN+GOeSKqkH7hHXWW7Diw3vwOHKmXP4syZFKefR9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhYNr0TE/EnFgeKlqgvfd4KPkiRGUb/rzflgeF0OP+zhwUWEpOVl9sO9UZ1nII57y12BSHe9UuZnN7p+DOXZxiIu/rc7+LnpXikp8RRoeLfhESZKhJdrymxmPK479cGqWbOjizKiKUrkOmLHyPUo5y+9UEEqgiPrH6czRKXB64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISKFRdnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4878C4AF0B;
	Fri, 23 Aug 2024 01:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724378162;
	bh=puQN+GOeSKqkH7hHXWW7Diw3vwOHKmXP4syZFKefR9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ISKFRdnVPX39YrTE072faJhMO2XezLPFPrtXKtDsQV6SBP1+MgXcl8tUXN1NTy0zc
	 APjVmsadCieJYSkMnGL8+BBYxOWCSMbct46xi12ALOMFNOsYKx6WjOMAyqdyjrFR/K
	 YUFh7Md3xNdwsLRfa9yYLEK1l2d2JCGDE/aasxdCAnzzkK09KDQ4iCkUoBIj7cq40y
	 nK8AN319jmPiMse5xpPzK6CLQ72YARoyLlZOiOYLOLXpbNfyiqXMJE4LbLxNd6IpN0
	 3hF6GPrDuFVP+W2Ixw8adrv8uuqqLDnLW89BvG52T4ff5yC0vNxaqK1rPODu6bmaUx
	 Cce2yN1MQSMPA==
Date: Thu, 22 Aug 2024 18:56:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH v4 net-next 02/12] netlink: spec: add shaper YAML spec
Message-ID: <20240822185600.67f51dba@kernel.org>
In-Reply-To: <dac4964232855be1444971d260dab0c106c86c26.1724165948.git.pabeni@redhat.com>
References: <cover.1724165948.git.pabeni@redhat.com>
	<dac4964232855be1444971d260dab0c106c86c26.1724165948.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 17:12:23 +0200 Paolo Abeni wrote:
> +        Clear (remove) the specified shaper. When deleting
> +        a @node shaper, relink all the node's leaves to the
> +        deleted node parent.

I think you should explain the other case too.
When deleting a queue shaper the shaper disappears from the hierarchy
but the queue can still send traffic. It has an implicit node with
infinite bandwidth and it feeds an implicit RR node at the root of 
the hierarchy.

