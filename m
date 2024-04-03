Return-Path: <netdev+bounces-84233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90606896201
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 03:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335F428B757
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 01:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3225A134B1;
	Wed,  3 Apr 2024 01:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="He5l/yN1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E7125CC;
	Wed,  3 Apr 2024 01:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107959; cv=none; b=YWRZO12ZmVUQlTbTHhPkFbDs7ptUz/W0Rmkh3FpljZb6SWIRPFkgWI2Mb1APlaQkhSlGXD3Exx8EH6Rzq6fvsYq68F/5PVqmp6dqaoCsv5YnDaEeNNmCsWC6JxC+ia2FhDw+oQg5ykblaSYFzDNWxFr5emM21W/Ns1R2IlHLqpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107959; c=relaxed/simple;
	bh=Oboaa00MtZpqJcZQ4Qg/6jeTJtT/d7JbGLI3XZvpfR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMEyaH0v1oAHAAaBF3tPgYrVqdp6L/AILc1FRke+yq9qpWlUXr7Qbe8PU+IkwdSa4KnpH4EXkhfZtozl78r/aM/Ph4kUcCLKaTzTu8Euzs4V7ubIfBybb+YGJFGQ4qWVLc5dnb2lx3pw0146FzqYV8ktrbRbCPvEnxqv/4X/dpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=He5l/yN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F789C433F1;
	Wed,  3 Apr 2024 01:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712107958;
	bh=Oboaa00MtZpqJcZQ4Qg/6jeTJtT/d7JbGLI3XZvpfR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=He5l/yN1ZyEm5maG6+l8s/LFRBCDTt0AY7sH2PPSoULJHn+m/op4bQY9iLI3yXcjD
	 YmpvCEhrq/bs+bh+lzpkGCWbzcuLEOSD3wm4XyW+IeprpX/Jz/zprpAw3F3xqNZpcm
	 RFpbyxrUEOEqp0J8T//wUMoae2i7psHmtwJE3VFgpnnI7gmian1VYO8feDGCB/TAFo
	 WO96VKK9aG+P/1z+5Cm7OdsBsPfufEZbym2+9WWLy87G8VqQhRdjNZsFgnvtTjYlcf
	 jStSAGuLB9yqBDL0pQJ83urFSbhX6r8hXLXqq5bo+2fdmPyZbrDESQTxEU1xi10A1/
	 3oRiEH6lA7TOg==
Date: Tue, 2 Apr 2024 18:32:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: usb: ax88179_178a: non necessary
 second random mac address
Message-ID: <20240402183237.2eb8398a@kernel.org>
In-Reply-To: <20240401082746.7654-1-jtornosm@redhat.com>
References: <20240401082746.7654-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Apr 2024 10:27:25 +0200 Jose Ignacio Tornos Martinez wrote:
> If the mac address can not be read from the device registers or the
> devicetree, a random address is generated, but this was already done from
> usbnet_probe, so it is not necessary to call eth_hw_addr_random from here
> again to generate another random address.
> 
> Indeed, when reset was also executed from bind, generate another random mac
> address invalidated the check from usbnet_probe to configure if the assigned
> mac address for the interface was random or not, because it is comparing
> with the initial generated random address. Now, with only a reset from open
> operation, it is just a harmless simplification.

You need to wait for the other patch to get merged,
then on Thursday after that the trees will get merged
together, and then you can post this :(
Otherwise we'll have a conflict.
-- 
pw-bot: defer

