Return-Path: <netdev+bounces-23458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EAE76C03F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 00:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15AF11C210E5
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95FF275C0;
	Tue,  1 Aug 2023 22:13:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AF426B10
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 22:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361B8C433C7;
	Tue,  1 Aug 2023 22:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690927979;
	bh=jTdnCVCL5QvUMWI3eEkPyJE/7MEWhbAfbemaubr4KGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DsFY2mvXIEOUUQpJxJo1D+fxa+ahDM4QIrHIk1v6Hdjl79/iY7yRNqOdhgIHMLdDW
	 cwiYuE1QCXGOWFMaFztiW4JkMzgvUPtKyWsnPL26WpY6XUJdeu9CGmu86zrE1pt2Qx
	 PZIpT4sJZ+0tRnqeQQ181y3hIyTVyuFMqujplIN0S527pgKEhJVRvZOKBxgutOPuAy
	 JXAmmibr5YtZKsQa6T/89j6k25XknjjaB50PA+D7ZwUFQgB5/PUo5dziqih1jII1S/
	 JEY8L7OMbtLiIXGb8gAf4J1NdH7NkdpZ0PvPAIaxpM9kgpvVyOWdqRmOrHvSxduw/w
	 n00ShnjjAExeQ==
Date: Tue, 1 Aug 2023 15:12:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rushil Gupta <rushilg@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, willemb@google.com,
 edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next 0/4] Add QPL mode for DQO descriptor format
Message-ID: <20230801151258.4b71989f@kernel.org>
In-Reply-To: <20230801215405.2192259-1-rushilg@google.com>
References: <20230801215405.2192259-1-rushilg@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Aug 2023 21:54:02 +0000 Rushil Gupta wrote:
> GVE supports QPL ("queue-page-list") mode where
> all data is communicated through a set of pre-registered
> pages. Adding this mode to DQO.

In case patch 4/4 does not make it to the list I'd like to remind you 
of the mandatory 24h wait period between postings. Sadly it does not
include patches not CCed to the list...

