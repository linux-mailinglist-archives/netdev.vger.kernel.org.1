Return-Path: <netdev+bounces-229207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99087BD9563
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6654C545211
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA25313E08;
	Tue, 14 Oct 2025 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MslwqJ96"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5751DFCB;
	Tue, 14 Oct 2025 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444892; cv=none; b=EC9WJ5RVPfFcwQncSAPXLP9uQIwVeDNUWmiK/0TJ7T5IaWa9A7X8Y7SjEoj01h/+/a2JGEjprmXMsbL8blu7Em41ppajqxcnAHdSjKbmkFojbaxsrZFouCFsEYl9MT5DfJ5cDupnXujs0sSYayD8xcwIlvOwvvByNmj6ILraIZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444892; c=relaxed/simple;
	bh=Y/4uY0Lz5BTlFMBRFNS2Jhr9rGcUdrgFivypjJGtpjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr+HqI/0Rg4NyPH3/TQUlj4I1j7ENyS5r83cwuFVI1KEGe0SZzDxREGmv+ZhbaS9AJYnf9nCC0PQ1nhb0T0u7kVAiSrp7k/9uFPsFYi+gdtF+HR5RSk7VY9eWYNrn/cyy6By+Ibe/YvqVyttADcmCIJsrZoSAEtD7GIr7dX5qO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MslwqJ96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D8EC4CEF1;
	Tue, 14 Oct 2025 12:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760444891;
	bh=Y/4uY0Lz5BTlFMBRFNS2Jhr9rGcUdrgFivypjJGtpjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MslwqJ96VwLA0lv88ChBPpjG6q7uTXOSv7pwEpk6GIZgx77dWOlsSPsFlplXRrEuw
	 cjS0tL+ahZqb9hmsQElPC3ttufQyCxY90C90AiPUcJu/gQDMNigy3phco9ZH15zk+d
	 qvzo66HEWqoVdNhClQ11W5e5OZsudoKtp2uYxcpe2mIdYbdfKaR5yqPlJwDWwW+hj9
	 32EwKTg3X7SPriyPPCRMoRNQXnOUwkoXuPklTyay39YXf6Tv2bsxD10H5xTQMHEKcU
	 BD+tKz14uKgHho819ULJ53e9tqejywcR30OgswiF0v7txv63wRlU5vcq/qLEDnazh1
	 QN1DsmHu9QinQ==
Date: Tue, 14 Oct 2025 13:28:07 +0100
From: Simon Horman <horms@kernel.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v2] eth: fealnx: fix typo in comments
Message-ID: <aO5B13AsTwpMMe5S@horms.kernel.org>
References: <20251013183632.1226627-1-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013183632.1226627-1-benato.denis96@gmail.com>

On Mon, Oct 13, 2025 at 08:36:32PM +0200, Denis Benato wrote:
> There are a few typos in comments:
>  - replace "avilable" with "available"
>  - replace "mutlicast" with "multicast"
> 
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> ---
> v2:
>   - also fix "mutlicast"
>   - tag for net-next

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


