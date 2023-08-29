Return-Path: <netdev+bounces-31302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D7D78CC2C
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 20:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F302810F2
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 18:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9288A18006;
	Tue, 29 Aug 2023 18:33:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813BA156DF
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 18:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEFAC433C7;
	Tue, 29 Aug 2023 18:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693334033;
	bh=7kdmRRxG0Ft04zM99AX5+/lx0joPJzeJkBDq9Uw9aFM=;
	h=Date:From:To:Subject:From;
	b=CjeddsuyGWeerba+T29uj5TxC8l5HYdIUXS0JGYWAOd5zuKlptdzqy8MVr+7VZi9S
	 1GWBNOsL3Na+AyGmLdKvt8DzxjQ7C9pHTz1Ub/XZrbZrRyQOnYEMOjYHjj3AL85l/H
	 K2MG2WzZkK/0dsvo0j5xBDw/Xpxg9KVqT66wtKxtF1hTv97mwIzSfZuKgau7sNXMLu
	 vkfnA/tKFvYVj8jV1ULiYwoO0r+0nYP9kzqEsfXr1tWRrDhmYH3+Q9dkLRRJ0JQZnB
	 SmN2QQwxQBjI1pZ22Ci9H6skR8nfi8h+HnyoxrrQXQ/zmTJlklDT63phj6ah5kc7sP
	 Gih8lCzQohNdg==
Date: Tue, 29 Aug 2023 11:33:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: netdev call minutes - Aug 29th
Message-ID: <20230829113352.7fed02aa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Meeting notes updated in the usual location:
https://docs.google.com/document/d/12BUCwVjMY_wlj6truzL4U0c54db6Neft6qirfZcynbE/edit

