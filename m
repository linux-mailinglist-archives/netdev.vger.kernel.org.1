Return-Path: <netdev+bounces-33349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBC179D7E1
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 19:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1146E28218C
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 17:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2BF9441;
	Tue, 12 Sep 2023 17:46:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345EA1C04
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 17:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18305C433C8;
	Tue, 12 Sep 2023 17:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694540800;
	bh=owJXBVHlX7rJEx7JkrcMWVhwJ1nZdaKqh+sxtE8uGRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pa+d4CXswzUcN6JHnF3ZlTaOflMu4vpji3R3TfSIu3q72KPKJLIVowUHWa4j8ZSYA
	 Ebsudp7m9LEfbCFyQfaVvBY4bjUvozr4xYwQb3KfKTUL3Pmt6yfZ3Fu8/Z8jK841H7
	 rB4n1W5rq0/howqTuaqKYbQiaBMprApvg41uN3+6mc/Hzh5uR3hhAJGwZo/MB2FpP5
	 hqxVyRyFNUhFSQIYj1UPiD6ui8JBJTPrS6th9V741to16PGeiMhAltEL2b8r46x6T7
	 LrmoBFAFyq2RiJZ60ys0gSI77kaOJIyeLx9wM69Ox4q4lB5LJh3c6fxhraDMXmRBzJ
	 n3aBI4FbJtTUA==
Date: Tue, 12 Sep 2023 19:46:36 +0200
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next] net: wangxun: move MDIO bus implementation to
 the library
Message-ID: <20230912174636.GL401982@kernel.org>
References: <20230912031424.721386-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912031424.721386-1-jiawenwu@trustnetic.com>

On Tue, Sep 12, 2023 at 11:14:24AM +0800, Jiawen Wu wrote:
> Move similar code of accessing MDIO bus from txgbe/ngbe to libwx.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


