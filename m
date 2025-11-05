Return-Path: <netdev+bounces-236084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B84BC383E0
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BAD3BA51B
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C560D2F6561;
	Wed,  5 Nov 2025 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ummLNO59"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEC02F6192;
	Wed,  5 Nov 2025 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382721; cv=none; b=AtAMB1+clGh7/V9XdwiZpclHzlQRBG7PvZynkuQWHgW9RUunjv1Q/itmjDNjI9w5/85IcpkCqS+K8pEQJ5yAfayvOlLbYUcwQAQaciR9aug17blMeOyAJPXdP7grGog0o/O0Qbwxf0pdGK0X8IKir3x7P8GM5up08N7+6+iigEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382721; c=relaxed/simple;
	bh=Egewitrs3XsYEJ70fe8RW61DSMSY8r6ma4/DDNmAH60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFoF1gh1LjTgbnXKxaeO1yhgK7JeWRSTWtG23HpJW9Lrzr5ZwPonH8Lozvo26MXVh7fA0lZf6It6ddyEY0ngauLMxe5YSROgUDAZYnUdoU6HJncBQAhMJKUHTcSNza++Zu8rgNmmcS6HqJQmjebScT2xitYfaSDrEHzO3HidWX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ummLNO59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6685EC116B1;
	Wed,  5 Nov 2025 22:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762382721;
	bh=Egewitrs3XsYEJ70fe8RW61DSMSY8r6ma4/DDNmAH60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ummLNO59I3UQdtn+nBed4QhZculMi9YTY5+WN60fy92HHzqx8rNod2sokKeZ/biwS
	 YTUkj39lOAy09l2KxKI/IJOYjrYUtJl4ZJEhZt791/cgb44xC5kwc1owWzMbE/Khir
	 h7xTOcirEw0NfXWVcUpeLYO12tYczG8eArr8/oXR61nl71+QCgjxtVjUVne1ZnHWXd
	 cZsOGvez0fXH/gV8Hk3Hh8I6eUAJ3B7VL9uJDbkOcKq/Ilgbb68FuGTRW9Tuue8xS4
	 j+Jldlk6ZSnzI498lAODP+AQ6/1/ed5NSfYdpFrlrqOl0jBlDTC33ZNDbZAgx9pmE4
	 hgxhyiCM5dQ3g==
Date: Wed, 5 Nov 2025 14:45:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: joshwash@google.com
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, John Fraker
 <jfraker@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Ankit
 Garg <nktgrg@google.com>, linux-kernel@vger.kernel.org, Jordan Rhee
 <jordanrhee@google.com>
Subject: Re: [PATCH net-next v2 3/4] gve: Allow ethtool to configure
 rx_buf_len
Message-ID: <20251105144519.2729e38b@kernel.org>
In-Reply-To: <20251105182603.1223474-4-joshwash@google.com>
References: <20251105182603.1223474-1-joshwash@google.com>
	<20251105182603.1223474-4-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Nov 2025 10:26:02 -0800 joshwash@google.com wrote:
> +	if (priv->rx_cfg.packet_buffer_size != SZ_2K) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "XDP is not supported for Rx buf len %d, only %d supported.\n",

No \n in extack messages, please.
-- 
pw-bot: cr

