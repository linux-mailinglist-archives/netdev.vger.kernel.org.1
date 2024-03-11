Return-Path: <netdev+bounces-79244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A14238786B6
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 18:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D237B1C2116F
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB69524AE;
	Mon, 11 Mar 2024 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ4oEThA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE144EB4A
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710179571; cv=none; b=RQNjOmyXRmCnB8BrVNsdHZJZL/hwOb/h7ektOIqMUQAalHiuF6BeeI3iXH0GgvO4SF1eno18antUQsJur0G421a4f6+MYnqFczotymM7R52PVP9BXwgJG9ZWRuJuk1AOSQlfDaakYJzUE4THm445JdVxqIQvR+hLrFDIh/h9W3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710179571; c=relaxed/simple;
	bh=Pq/VrGYoi5wgkMhwkZQuka2x8JaohAlIJV57NTIwyEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RcciIp7Km58BXqumQsju6sUQYr8ESF3gk8e5O6WfQQ+1J1N6pRb7cpiILX1dYaJ8jA/b/9FK5aVdaNEfeSWShmNLddNjRyl5FIsIMKnqZBqyw2Gf41X+HTPTJS/5z7AOZEMBuslEh6mGymsO7qJY0gDSAGYn4NvuhBJVdmL/1KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ4oEThA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24513C433F1;
	Mon, 11 Mar 2024 17:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710179570;
	bh=Pq/VrGYoi5wgkMhwkZQuka2x8JaohAlIJV57NTIwyEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aJ4oEThAjDsk8xudEVnKnuZrY88dH9XuGf+eZS1Eyqc/krTXCwwmSFBvOWbBZCjdU
	 dbVva/M+HQKKgtdVUCG+MkMy2oIxoZcuiemZ+s4DxDZcDy0asyliSkgIMj3AGlv/j1
	 fM2C8nTQNyCEJP7k4O58dKTPRcOnztMTPZtlTCpUsZt33F/yrcIsD839fIVeW8ZTKz
	 v9BmF8fKMQlCfFyZ5r9++O8Bgqx0uaG+bdK1PQAssokMwr9ItGWdwW+Y2S0AfWYl6f
	 Sa1ZS/NvkPUlz1i03up313ABqz48+LwrA6h81kD1psauHeVGnsVK4nRFuC9Eq/6XnX
	 aSW8O4W/KMAWg==
Date: Mon, 11 Mar 2024 10:52:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
 <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 11/11] selftests: forwarding: Add a test for NH
 group stats
Message-ID: <20240311105249.5c350e75@kernel.org>
In-Reply-To: <8734swlmjh.fsf@nvidia.com>
References: <cover.1709901020.git.petrm@nvidia.com>
	<2a424c54062a5f1efd13b9ec5b2b0e29c6af2574.1709901020.git.petrm@nvidia.com>
	<20240308090333.4d59fc49@kernel.org>
	<87sf10l5fy.fsf@nvidia.com>
	<20240308194853.7619538a@kernel.org>
	<87frwxkp9v.fsf@nvidia.com>
	<87bk7lkp5n.fsf@nvidia.com>
	<20240311085912.5a149182@kernel.org>
	<8734swlmjh.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 17:30:54 +0100 Petr Machata wrote:
> But I don't think SKIP should trump PASS. IMHO SKIP is the weakest
> status, soon as you have one PASS, that's what the overall outcome
> should be. I guess the logic behind it was that it's useful to see the
> tests that skip?

SKIP is a signal that something could not be run. People maintaining
CIs will try to investigate why. The signal for "everything is working
as expected" is PASS, possibly XFAIL if you want to signal that
the test didn't run/pass but that's expected.

