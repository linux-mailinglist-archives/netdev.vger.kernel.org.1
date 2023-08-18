Return-Path: <netdev+bounces-28974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BAD7814B4
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 23:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3B4281E03
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 21:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB3A1BB2E;
	Fri, 18 Aug 2023 21:24:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810DA1AA90
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 21:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E71C433C7;
	Fri, 18 Aug 2023 21:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1692393876;
	bh=Wdz4oVuBLe9dL/FbEM8zLUrqIvKI32lgagofb0qvY6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qCq6FBHKwur8aDhPsmBJ8x7a/pO6VKC1iTCOZWMlrV+nEghj+H0DqAjTnOlZUR00P
	 OdozVSYiigsj0UhUy+ly+qwBkX+RJEOGfUzAj4Hwm6GEpTCj7+gItKltc+AVOsfrqs
	 5g3zd+1+RH9uR0hpRVYfZeJOm9UwkwF1061rIaxY=
Date: Fri, 18 Aug 2023 23:24:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Evan Quan <evan.quan@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, johannes@sipsolutions.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alexander.deucher@amd.com, andrew@lunn.ch,
	rdunlap@infradead.org, quic_jjohnson@quicinc.com, horms@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [V9 1/9] drivers core: Add support for Wifi band RF mitigations
Message-ID: <2023081806-rounding-distract-b695@gregkh>
References: <20230818032619.3341234-1-evan.quan@amd.com>
 <20230818032619.3341234-2-evan.quan@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818032619.3341234-2-evan.quan@amd.com>

On Fri, Aug 18, 2023 at 11:26:11AM +0800, Evan Quan wrote:
>  drivers/base/Makefile                         |   1 +
>  drivers/base/wbrf.c                           | 280 ++++++++++++++++++

Why is a wifi-specific thing going into drivers/base/?

confused,

greg k-h

