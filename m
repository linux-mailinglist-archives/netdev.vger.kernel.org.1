Return-Path: <netdev+bounces-114354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBEB942441
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 03:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CF8282C82
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 01:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06909846F;
	Wed, 31 Jul 2024 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obpbQmUv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62A28F54
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722390346; cv=none; b=dvckembxK3kxb3Wp6n9z2TLbFhNox5WZKErHkwjuaSIubsROoDZXWDNIbdHGH3isD12WX8Sy6TIICh7GavTyIsanGRbN0e+E0HfW0a8fYrsTqGwIZ4n6qP1c65gzUpkBMn7gnWHyNAPmASnwJC9OQpW1eytiE6R6L201izVahBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722390346; c=relaxed/simple;
	bh=uEBbjv/UZvXxgq11vC4o6tVCrYRfLMSM8+FKZQhrWSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MkX5x8bNvPpkpRmj78ImKITHNoiJuGzuBGSD6NV8hXCgugFYMsrgm320Q4wRZgBlnbXDNqGU74gnxzLTU2jiSWcEfLDzHNWv+ttfWcQDsEVhhX2mR205GihPXqqZYu0jxqgZRk6d6g769xYxhFe4Nxv37aHYfGSkS9r4Eq505ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obpbQmUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34303C32782;
	Wed, 31 Jul 2024 01:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722390345;
	bh=uEBbjv/UZvXxgq11vC4o6tVCrYRfLMSM8+FKZQhrWSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=obpbQmUvIPZmkvt2Jm8HmMIMsskLouC80/Qg0hWftl8754cEAcJoM0Z0fN3PZ5hOb
	 4IirqXr4vZjt0fC09pNB2ziLkvPe4PxX7cUFp55gEdouxOG2BWZAEvQFOC3KC5vdMG
	 DNC4nmOIjSeMoGF0w82zYLB32XqvEziNrA/jKU8uXUUD/VBv+E1q2jvqgSX56w5L10
	 4Z1AHe/obyeixAvaVzz8tCt90fHJu/wWuLCRlVcu0q+1gBKq0B88GLheU55n64fReQ
	 eFYKfdVrYcRqANhaM6t2H9OiSUsNjqtrJ0o6JmLkT6ROfz6FDkomlkIQqwf7G3/mbS
	 VBdEAJjlu6vFQ==
Date: Tue, 30 Jul 2024 18:45:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, michal.swiatkowski@linux.intel.com
Subject: Re: [PATCH net-next 00/15][pull request] ice: support devlink
 subfunction
Message-ID: <20240730184544.60ff163c@kernel.org>
In-Reply-To: <20240729223431.681842-1-anthony.l.nguyen@intel.com>
References: <20240729223431.681842-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 15:34:15 -0700 Tony Nguyen wrote:
> Currently ice driver does not allow creating more than one networking
> device per physical function. The only way to have more hardware backed
> netdev is to use SR-IOV.
> 
> Following patchset adds support for devlink port API. For each new
> pcisf type port, driver allocates new VSI, configures all resources
> needed, including dynamically MSIX vectors, program rules and registers
> new netdev.
> 
> This series supports only one Tx/Rx queue pair per subfunction.

I'm a bit surprised not to see Jiri on the CC list here, didn't 
he provide feedback on this series in the past?.. Yes he did.

Please repost and CC everyone who gave you feedback.
-- 
pw-bot: cr

