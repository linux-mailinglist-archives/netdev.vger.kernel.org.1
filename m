Return-Path: <netdev+bounces-210572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A65DB13F43
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4035D17144A
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B842A2741AC;
	Mon, 28 Jul 2025 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByRBp+6Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0EE2741A1;
	Mon, 28 Jul 2025 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718038; cv=none; b=HP/Rwi4G8RTOVND7wnqcD09qugAT7KXNXgke1TBKsTCAbyoKGTnd5pX4KKqjJLKKbYz8CAx5oKAyBmDoQjLq3lYURIECeMFWj/fQa80Ouk4OBjNYSh6HBsGVbpCdak5hLdYNbWqh+XM7q6Qq34mvuOvxXlDOTOF65L4kulw7aWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718038; c=relaxed/simple;
	bh=KD/aa66YOcDMMN953jPL1kTDzo7Vl/h2knG/JAL+9wk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=hOIKXthKCpOE4wNev1iRi6YSnSNFGcMkfMcpx4xGylwatekdHnaFnyWMGgJvAEmEGp6+9fVC81l8lpOn5PO9ryWV6paNdpKjDGjzxLhTN2ohb8FzrNR6dLsYucA8MuBFck05d3ctSrqrC+TjWhB0QsrqDxO30jM3ytLlu5HRkwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByRBp+6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D989BC4CEEF;
	Mon, 28 Jul 2025 15:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753718037;
	bh=KD/aa66YOcDMMN953jPL1kTDzo7Vl/h2knG/JAL+9wk=;
	h=Date:From:To:Subject:From;
	b=ByRBp+6ZaPSC1QNsBj47Q4zOr/hC1TU1VIgymwtvVnWhr8VdyU3wqPHjRjTGSSIpp
	 dsMMBQcyLrFB7RKq9FsxgCz/V1UBJbhU0nWGDyd0C82zKnsyc+xftcgB8RAJSRnZ4n
	 u9meivFOnKW2BJVtggWaF+ovq2YLLd53EW60yV6o2h87i9YEjciSWSf4xANPHj9oJC
	 WEM9xuMI/NPIfN/Hz4g6i0jBQC3DFkFoi5N/aiobrDori3WPrSpLuYENYD6q2JJD3F
	 eb2elK2bmeTb2H1ijMuDxHuYFMne3crgT9OGrNE66eqza0q192hZxc/OM5Q8UNpmCc
	 cExVlt7gIwl0Q==
Date: Mon, 28 Jul 2025 08:53:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Jul 29th
Message-ID: <20250728085356.3f88e8e4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join

We have one agenda topic - Arkadiusz Kubalewski says:

  Wanted to meet and discuss the need for clock id on microchip driver
  provided by Ivan, I hope we could have a meeting to brainstorm some
  ideas and decide next steps on how to deal with such cases.

I can also provide a quick update on the netdev foundation activities.

