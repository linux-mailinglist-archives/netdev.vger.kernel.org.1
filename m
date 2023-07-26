Return-Path: <netdev+bounces-21151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5ED76293A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 05:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB231C20F15
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 03:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240CE1FD7;
	Wed, 26 Jul 2023 03:23:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6D115CA
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1AEC433C7;
	Wed, 26 Jul 2023 03:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690341832;
	bh=ng5DXKEW/N72oQKlESKJ9zgU19pEjauob6VDV+J67YQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=REJBLy7z+EgwaglFZtthpIeG4b7+3BI/P30GSWXMw4q+R9XkFZ6BkYCAh3nah0sWt
	 VZkzXQoJFy8s0fl7RmKkdyyGrzOrai8ayIy6S1qBUL59Ccuucmv9TEM8NI4GiAq2hq
	 SlHIK15vXRW9ls6XCj6R9T1II1J5k4if4Nn1EFi7zjd8MmC+uW0BQ6/6zNAJUf32rk
	 7dBXRlS+2Fm4N3FlvUazLn7xito7dLcffUL7UEhR1hT85UEpFL++9imQfTLX379kTW
	 W6HJBolxzJgNB+j/0Pgo9D9D3mw8md+UgSQ25LLHHt7dd0LEuKgY8M8kndCARQ5BsW
	 zD0zKU8uKUUkw==
Date: Tue, 25 Jul 2023 20:23:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: ngbe: add ncsi_enable flag for
 wangxun nics
Message-ID: <20230725202351.6d615c94@kernel.org>
In-Reply-To: <2E243F8C-76F8-4792-B8C4-201E65F124F6@net-swift.com>
References: <20230724092544.73531-1-mengyuanlou@net-swift.com>
	<6E913AD9617D9BC9+20230724092544.73531-2-mengyuanlou@net-swift.com>
	<20230725162234.1f26bfce@kernel.org>
	<6D0E96D7-CDF4-4889-831D-B83388035A2C@net-swift.com>
	<20230725194456.7832c02d@kernel.org>
	<2E243F8C-76F8-4792-B8C4-201E65F124F6@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 11:12:41 +0800 mengyuanlou@net-swift.com wrote:
> Another question.
> Then, after drivers know that portx is using for BMC, it is necessary to
> let phy to know this port should not be suspended?
> I mean this patch 2/2 is useful.

Right, I think being more selective about which port sets
netdev->ncsi_enabled is independent from patch 2. Some form
of patch 2 is still needed, but how exactly it should look
is up to the PHYLIB maintainers.

