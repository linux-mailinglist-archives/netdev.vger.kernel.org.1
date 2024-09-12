Return-Path: <netdev+bounces-127904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6DA976FC3
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F271F24A70
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAAA1BE860;
	Thu, 12 Sep 2024 17:49:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73865149C50;
	Thu, 12 Sep 2024 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726163371; cv=none; b=p+XWhJR5H9BE5ydAgT9vlfqyXFeLaSzIGT7AGHv5zf4HrBC5RzpFJWfdOhJIznsR98LhyYwuCzMMsnLADmKWM12ZyGiBcACvGbFE1RKxyTbHiVhUMCNBgfVhuN/q5mUExjdgV84snNj7HoyjP4lKStJyLFUHq2eARKa7kKIEaG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726163371; c=relaxed/simple;
	bh=C5U1bcY1T+1rchz/nfQuV9RtGy8VEcB1pZLozPFTIYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYAhsNx7E6N0bovpMx9FYcEAhI2eKRjE6E8WtwiEs8Dn5H0ZRAiXWDwAYhwBxaVgbdEF4mrkClt4d0o1C1F8qZNmFnw7PLXDwi0ggerWv4y47mdVvMq9MjEymtSnIdDSVOmaQA1uV7cmPaTrBD5IWMIDIhuaQiYS3RXvL8OTBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so84017a12.0;
        Thu, 12 Sep 2024 10:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726163368; x=1726768168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aG6T1eQjFkj0EwYfybn/Brg9qKOXhI/1MoAEcTM2NxE=;
        b=AOpkFbOZbH1R6l+QAGi3ds1NddeWAviywmQnEcQA2ImLYC9znMyp+o0u1UK8eRp0/7
         T/wsfv6Q7q3vfe11VT6kG74PFObf1Gh1AtOvPAoiv/RfoMWC/zOGmb7uK3xknTp6RAyZ
         nr4YHIP4irTbxAtqBunrGWWrZROSSNSJWNWhyL9wvrh4V1BgY8S/WsPS1A9+Q6S9F3LU
         hgG/EB2GPODGhmJizeG+H4wTsEw6la1dHlIbv7XMR5PqIofi9Ze1ade/iefjcgNTnDMg
         YaQcE3k18CdyoN9h0SR8qFvWhM4JEvqq+EXUi6y30eqKA5dtZaHUvoc9TeTvJ2nsD5cE
         wQww==
X-Forwarded-Encrypted: i=1; AJvYcCUf/o8qEuWEx4retNbTvxWfTuCjmp5Vif7gDzrH55QfqzgSNIoLyqBiAkQo6rxO3FGDOMqm/KTaVYbRR9E=@vger.kernel.org, AJvYcCWW/QgHattUk1/FrVbeDfvtnPVS0XuFBHewSN81A/9XlYanU06rh63UuH7MwcNxKE0XLPmEZL7V@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8NC+qmBgAmxN/xdVbTAPC7D2h3B/7Wmykkq3nufd406v5yBtC
	kdD1UjxN1ZywxZ5m6mf9xGSIoCJh7T5MMlbIu5DWWNXGgc5BYlCQ
X-Google-Smtp-Source: AGHT+IHrEJDc6pS8fzTbZTav71UY+P1dnrFfHwbVRdt4kB6psPXPJ4F6J3gL+HuwtbG40G5/7nxJuA==
X-Received: by 2002:a05:6402:2803:b0:5c3:2440:8570 with SMTP id 4fb4d7f45d1cf-5c41e1acc7amr68881a12.26.1726163366674;
        Thu, 12 Sep 2024 10:49:26 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523bfsm6832356a12.53.2024.09.12.10.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:49:26 -0700 (PDT)
Date: Thu, 12 Sep 2024 10:49:24 -0700
From: Breno Leitao <leitao@debian.org>
To: Maksym Kutsevol <max@kutsevol.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] netcons: Add udp send fail statistics to
 netconsole
Message-ID: <20240912-honest-industrious-skua-9902c3@leitao>
References: <20240912173608.1821083-1-max@kutsevol.com>
 <20240912173608.1821083-2-max@kutsevol.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912173608.1821083-2-max@kutsevol.com>

Hello Maksym,

Thanks for the patch, it is looking good. A few nits:

On Thu, Sep 12, 2024 at 10:28:52AM -0700, Maksym Kutsevol wrote:
> +/**
> + * netpoll_send_udp_count_errs - Wrapper for netpoll_send_udp that counts errors
> + * @nt: target to send message to
> + * @msg: message to send
> + * @len: length of message
> + *
> + * Calls netpoll_send_udp and classifies the return value. If an error
> + * occurred it increments statistics in nt->stats accordingly.
> + * Only calls netpoll_send_udp if CONFIG_NETCONSOLE_DYNAMIC is disabled.
> + */
> +static void netpoll_send_udp_count_errs(struct netconsole_target *nt, const char *msg, int len)
> +{
> +	int result = netpoll_send_udp(&nt->np, msg, len);

Would you get a "variable defined but not used" type of eror if
CONFIG_NETCONSOLE_DYNAMIC is disabled?

> +
> +	if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC)) {
> +		if (result == NET_XMIT_DROP) {
> +			u64_stats_update_begin(&nt->stats.syncp);
> +			u64_stats_inc(&nt->stats.xmit_drop_count);
> +			u64_stats_update_end(&nt->stats.syncp);
> +		} else if (result == -ENOMEM) {
> +			u64_stats_update_begin(&nt->stats.syncp);
> +			u64_stats_inc(&nt->stats.enomem_count);
> +			u64_stats_update_end(&nt->stats.syncp);
> +		}
> +	}

Would this look better?

	if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC)) {
		u64_stats_update_begin(&nt->stats.syncp);

		if (result == NET_XMIT_DROP)
			u64_stats_inc(&nt->stats.xmit_drop_count);
		else if (result == -ENOMEM)
			u64_stats_inc(&nt->stats.enomem_count);
		else
			WARN_ONCE(true, "invalid result: %d\n", result)

		u64_stats_update_end(&nt->stats.syncp);
	}

Thanks
--breno

