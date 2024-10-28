Return-Path: <netdev+bounces-139487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B431D9B2D33
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 11:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7996D2818E0
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 10:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370CE188722;
	Mon, 28 Oct 2024 10:45:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061B417E010;
	Mon, 28 Oct 2024 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112349; cv=none; b=gIJRLZjs99ZwVYVxIiugCQtbcDMk8KXHhYJmlWcXzBas9wlxEimLz7dC2lgSH/EKf2GTlZOwN82K6mBqJLbn5kGocTpHOlASteu0MyOzVuOMO0vDn5DYh7Z1T66sccuFoE1yh96ZZjy7fvQ0eAuje2jXCpac09seAl53rNprQDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112349; c=relaxed/simple;
	bh=/+NlGtr5UWKxljcWxlHZsnuOPekHlyOJCpw1WSUA0aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhyhOax+jOsnIYEApHVrwSl5LqRopMpYRdRogh3vHoDQzqC6BlLFc7HWi2zwYtCeZ9YUMxJBDjyf1d75hmNpoNG/S6ZlLWBrlE2SwkwkAeoqBmPI/gkPg6ShlSj7/F5YewfDuSe8PmVggWbHcaKo0wifMmaqMYcSU4kZBDs8D7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so5559774a12.0;
        Mon, 28 Oct 2024 03:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730112345; x=1730717145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkGBCZ/REVoeaqYNgdus/UdXUHrP1xIBai8itw23OJ8=;
        b=tI0RX3pRqyELHTIXsOWSXfy/wJcIxcmkMSY6B3g6QlwcjAp7lhFhr2Dtm6YSTejyou
         2OX9QLifiQkijI+SGAnJnzGHvq3DBhHO0UVlVRvgIi8OOA9/0RGzofCPqXtFXLGmvNRb
         M7eU/h9u0lBem7dPlhgfKWG3vgrvnX73oSy+uD6dVjSILBuc2F0IkpiQvJuMmbAxAnkt
         Tl2MOANnRgOfxxPFe/Oezf9Xx781mIXzvNPKvgv2D/Z8cCcWJ5U07JfJ+JWidzEaBVMZ
         ETIl0N7QizGWX6IH5W3eMT13wEJC5EpUCLQrA4Jo5cV5C22E8hJxYYPpkXmlPo6BhAsR
         piRA==
X-Forwarded-Encrypted: i=1; AJvYcCVq8BjkkUykSu92lvSIazB5d+0ouZlZhONRMhVm5CVENZYF62M5xzy4wHxxmT21Sgjwy8LBI1A4Mi0RoU+V@vger.kernel.org, AJvYcCW11czrTdhU3WhNMT7EoThUDLqzPdG5WKqeCuhzGy4cHtpO8Oq0ksomNRvr1bue1vqbpHs56I5P@vger.kernel.org, AJvYcCXcJfC/sBe8sjuzgTEmGFgsZV1RotpfqQja1kni71lqKBegGOg63rR8yLQtzUhHommpuTbCsDQXfis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCGREVk57bassVwkHqAMpX4q9EADcEIihZSThaLo0jqNDXF+u7
	8oa0KHrbmwv4TnI+On8G6avGdwjMGhvKwcevmjSPpBNYFd8gERt9
X-Google-Smtp-Source: AGHT+IGfZC2hqbmc5CjvL/6dFGd7MASPl5G7OQxBAZht1Sh7nu272ahG2OdmRCjCi9ps4Ls86Pxkww==
X-Received: by 2002:a17:907:94c7:b0:a9a:4f78:c3 with SMTP id a640c23a62f3a-a9de5ce2538mr813096666b.21.1730112345017;
        Mon, 28 Oct 2024 03:45:45 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f299099sm365933666b.101.2024.10.28.03.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:45:44 -0700 (PDT)
Date: Mon, 28 Oct 2024 03:45:42 -0700
From: Breno Leitao <leitao@debian.org>
To: Maksym Kutsevol <max@kutsevol.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] netcons: Add udp send fail statistics to
 netconsole
Message-ID: <20241028-intrepid-silkworm-from-vega-55765e@leitao>
References: <20241027-netcons-add-udp-send-fail-statistics-to-netconsole-v4-0-a8065a43c897@kutsevol.com>
 <20241027-netcons-add-udp-send-fail-statistics-to-netconsole-v4-2-a8065a43c897@kutsevol.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027-netcons-add-udp-send-fail-statistics-to-netconsole-v4-2-a8065a43c897@kutsevol.com>

On Sun, Oct 27, 2024 at 12:59:42PM -0700, Maksym Kutsevol wrote:
> Enhance observability of netconsole. Packet sends can fail.
> Start tracking at least two failure possibilities: ENOMEM and
> NET_XMIT_DROP for every target. Stats are exposed via an additional
> attribute in CONFIGFS.
> 
> The exposed statistics allows easier debugging of cases when netconsole
> messages were not seen by receivers, eliminating the guesswork if the
> sender thinks that messages in question were sent out.
> 
> Stats are not reset on enable/disable/change remote ip/etc, they
> belong to the netcons target itself.
> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Closes: https://lore.kernel.org/all/ZsWoUzyK5du9Ffl+@gmail.com/
> Signed-off-by: Maksym Kutsevol <max@kutsevol.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

