Return-Path: <netdev+bounces-60212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E1F81E1E1
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 18:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277E71F2229E
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 17:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761F052F8F;
	Mon, 25 Dec 2023 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AONohBhD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD3F52F6C
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 17:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AF6C433C7;
	Mon, 25 Dec 2023 17:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703526313;
	bh=5ecGvf8AUEGfc/cGrhlBf5GR+QeAXj2CzVIHXi9wJ7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AONohBhDj/gbaCLEAHVmdPBhz2nqXCEXZeM6XRajebDMm3SXlS4KfK0gaYexGNM5K
	 7QF5T8EzHNipMH7lV6xWrDShcmJUJ5GDmMPN4Thyf916fcg9u+3424dQb2/lBbL+od
	 S/odeXYRr9d13ZNGczQxPPdYkjLiFEmI0B2nm1qCU0A+QCZqG6h5RAmnBk8M63rj1k
	 Y5i/4cuDfwseYrQ9FPok1IZ0GRAgz5fMwLO6+P+c2wAhsTb/G+xU5WihasyxRVSpkg
	 nzDtj6BR+W423AVonS9qlTBHBH5LUV3Za3GGw3c+NyiUSLJ8KND/pfCq45T9oUybHy
	 KIQv17k2cpUAw==
Date: Mon, 25 Dec 2023 17:45:09 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v2 03/13] bnxt_en: Re-structure the
 bnxt_ntuple_filter structure.
Message-ID: <20231225174509.GP5962@kernel.org>
References: <20231223042210.102485-1-michael.chan@broadcom.com>
 <20231223042210.102485-4-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223042210.102485-4-michael.chan@broadcom.com>

On Fri, Dec 22, 2023 at 08:22:00PM -0800, Michael Chan wrote:
> With the new bnxt_l2_filter structure, we can now re-structure the
> bnxt_ntuple_filter structure to point to the bnxt_l2_filter structure.
> We eliminate the L2 ether address info from the ntuple filter structure
> as we can get the information from the L2 filter structure.  Note that
> the source L2 MAC address is no longer used.
> 
> Reviewed-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


