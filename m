Return-Path: <netdev+bounces-130315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8FE98A11D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F96B26549
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9C818C914;
	Mon, 30 Sep 2024 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRuoXKwF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE0E183098;
	Mon, 30 Sep 2024 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727696936; cv=none; b=Rty80uD8UeQ2dv+kF6VAPlZH8WsL9rl6L797++rejT9zGA/Up3Vn0BcrIiImPb+WasoZaUxf8+WqrcXTZHQULGj1BUlHXpz6XujC4vBb81loXTwulrWa6yCHYsh/3b8VPJ+uuGgyV1bo1E1cJ/SASDCcdgcNouuejPB/moVIzRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727696936; c=relaxed/simple;
	bh=PzA7nE0jNLm5i75blcKOOqRZyMoVOw5M0ziyUHfMO24=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=e0YudXlW4kOYQu5r12unbsE6xFj59Ao5gWfYL3I75vyn74XIANLXiGHODu6J1gq2tHsyMVb+qZN/9Gv72NUHhuQ5WG1uVUJ/fmrKnB8RZOiUaBipvSK4gCIoPq6YuUDQ7T+/ckMAfdNoPTOFlX974FxXDXOmoL/Sap7PWBThpDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRuoXKwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46584C4CEC7;
	Mon, 30 Sep 2024 11:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727696936;
	bh=PzA7nE0jNLm5i75blcKOOqRZyMoVOw5M0ziyUHfMO24=;
	h=Date:From:To:Subject:From;
	b=ZRuoXKwF5Qd0QhXQslbXyXPFY56CXo0yy3XPSITUGoTKUvoyp8Mky2EW8wv4PmDly
	 uG13TbOdFPiTFl/ZKkeNJ/e9TjcwCU5B7Atrl06jUJHEgw0jwSVwvrtxd8Qh5DbsgA
	 H8FPClh720AItQAG+KMdhU5uksLvJI6VuZvzusPIAXm2uOCUHyP1sqRATdpQU8bMh6
	 BwA2VJqk5xBFkY1zO5C1gNs4uXEM1vR3RqCaGCuwSXMqAdsOHPL5YuyF/oeJVWS9g6
	 FGBMsLW7Qg/yOi8ug7FolqxxcD5XbDT40XXEQ86Tbg6iKnFGQezQkI1IXy9HmdgVrh
	 5vBITFGl6YutA==
Date: Mon, 30 Sep 2024 13:48:52 +0200
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is OPEN
Message-ID: <20240930134852.7c7b1335@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Back to normal development!

