Return-Path: <netdev+bounces-48728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6EF7EF5B5
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3C71C20404
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1FE3BB5B;
	Fri, 17 Nov 2023 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJIQ5NcA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B308F7E
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF16CC433C7;
	Fri, 17 Nov 2023 15:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700236322;
	bh=G2n7deVUZ/9TWAvvUNXI67t15+hWbeorrwkgSzYbTpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TJIQ5NcAATTS0HLyr2hlKjchJd8EoMmw8iN3wJHixG+P12e42HmrcG0qpxxYRhKxh
	 6QDg5rpAoGqegJzBvh+GfijNa4YlZrS7zkX/IMNCBnliy/S+sJ8QZosBinGr/EUclm
	 UYGSj5RO9kyqovccT4wjrUwu+OgdyonTuJX9z3fCsWxe0fyXtrWeINE9DLgKSwkOhN
	 AGHSiItbQGnEdamzKsu5Tqjah6wyLZdDKg8GnDIScJj9p2y97U8SNvHl5EbhxKptjq
	 Ftc60KwNatvYcLMfr9L/TNUthoui4zsIRuA8iPBh3GkfTThjiFQp/+Pa93K0+FkxsH
	 NFKfCiZtPuvRw==
Date: Fri, 17 Nov 2023 15:51:58 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 09/14] mlxsw: Extend MRSR pack() function to
 support new commands
Message-ID: <20231117155158.GJ164483@vergenet.net>
References: <cover.1700047319.git.petrm@nvidia.com>
 <07ddefc8ba97f401402ba2e43a7d37677b26cc16.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07ddefc8ba97f401402ba2e43a7d37677b26cc16.1700047319.git.petrm@nvidia.com>

On Wed, Nov 15, 2023 at 01:17:18PM +0100, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> Currently mlxsw_reg_mrsr_pack() always sets 'command=1'. As preparation for
> support of new reset flow, pass the command as an argument to the
> function and add an enum for this field.
> 
> For now, always pass 'command=1' to the pack() function.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


