Return-Path: <netdev+bounces-44971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1284C7DA5CF
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 10:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90D17B2128F
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 08:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191798F56;
	Sat, 28 Oct 2023 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lHKN7Ow4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0AF5664
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 08:26:35 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B805EED
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 01:26:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so451663066b.3
        for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 01:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698481592; x=1699086392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eJhQkTYQByEPzp5iF0kZrmUfhaZVU4sB1U1O9fNnad4=;
        b=lHKN7Ow49hV20GxheiY0qXa6Wb/S5s6wLK+s+qonTCfJXjVsGUWLXFKC89Z6Q+WzBq
         yQAEquaGEjL37HgKRw82kzhfAf5USpH3Rk/JVQfFNI6anv/GR5Ebh2u5zrwrVAooFZX5
         CIkTQVt2CWULg1pTow4X22yBpdV4vgnLTpJOhjZtQjdyd9Fc3sE0GzmFB0CS25908mM+
         aO9y/oPa9C8189EON3S9znIgFaidB2e5HQxEqdzY3NxArSMUHSC+Th6bp+ke8e9a3uTP
         5uOA8uFydAfgpiyoDoMp58eqk0s31b6gy0S+T9C9ju9BFkeGN8qR/ZTykraiBOGI0Ag+
         75Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698481592; x=1699086392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJhQkTYQByEPzp5iF0kZrmUfhaZVU4sB1U1O9fNnad4=;
        b=B7W1JVPi0R2BTLN+Z28PynPjg7Eiy50sCg3oyqz5foLUTSQ4dMKjxTt5dT0r72J3Eb
         7OJZbA3gGN9AQThb8GZrnm4cvpel+OtEG1XMMYMqRjFf4U0ifJt6Aj3o8rlqOkenZFAH
         ep3+HFyPUfdFYiu7zhZK3tUBiyqSGpsqdgpPchyK0AHh9Pw4o7EhY1b40dc82gQQN5MW
         oF9Tf5v+DZ8Dk6qEx5TTQXSTuXnmb1GNXr9YyhhVFi2Oq5HFrXKykssX/zxXwbYPiPHf
         ZwAmfoNJVvUd9av4UQPEsz6PcOi63k6X/xm43ZmiYQmCqClQCOhUL2Yaq/ktyf66ENwb
         R8Fg==
X-Gm-Message-State: AOJu0YyLEN2OQ326tM8pK7Jkl9HQTxhLUdDYy2NEA9xzYg0m7llDQxHW
	zo+e58Dtk3OlRN+4S5qjoSEX5g==
X-Google-Smtp-Source: AGHT+IFT/Q0SSMzgfM0wM05xnWL7uI2zo7YMO3TkPKajP7gwViLLOWD+0duceRfvnMA3Om+oP9Hxzg==
X-Received: by 2002:a17:907:9815:b0:9bd:f031:37b6 with SMTP id ji21-20020a170907981500b009bdf03137b6mr3740555ejc.49.1698481592122;
        Sat, 28 Oct 2023 01:26:32 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id i14-20020a170906a28e00b009b27d4153c0sm2435670ejz.178.2023.10.28.01.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 01:26:31 -0700 (PDT)
Date: Sat, 28 Oct 2023 10:26:30 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] tools: ynl-gen: don't touch the output file if
 content is the same
Message-ID: <ZTzFtiReRQUSKdoq@nanopsycho>
References: <20231027223408.1865704-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027223408.1865704-1-kuba@kernel.org>

Sat, Oct 28, 2023 at 12:34:08AM CEST, kuba@kernel.org wrote:
>I often regenerate all YNL files in the tree to make sure they
>are in sync with the codegen and specs. Generator rewrites
>the files unconditionally, so since make looks at file modification
>time to decide what to rebuild - my next build takes longer.
>
>We already generate the code to a tempfile most of the time,
>only overwrite the target when we have to.
>
>Before:
>
>  $ stat include/uapi/linux/netdev.h
>    File: include/uapi/linux/netdev.h
>    Size: 2307      	Blocks: 8          IO Block: 4096   regular file
>  Access: 2023-10-27 15:19:56.347071940 -0700
>  Modify: 2023-10-27 15:19:45.089000900 -0700
>  Change: 2023-10-27 15:19:45.089000900 -0700
>   Birth: 2023-10-27 15:19:45.088000894 -0700
>
>  $ ./tools/net/ynl/ynl-regen.sh -f
>  [...]
>
>  $ stat include/uapi/linux/netdev.h
>    File: include/uapi/linux/netdev.h
>    Size: 2307      	Blocks: 8          IO Block: 4096   regular file
>  Access: 2023-10-27 15:19:56.347071940 -0700
>  Modify: 2023-10-27 15:22:18.417968446 -0700
>  Change: 2023-10-27 15:22:18.417968446 -0700
>   Birth: 2023-10-27 15:19:45.088000894 -0700
>
>After:
>
>  $ stat include/uapi/linux/netdev.h
>    File: include/uapi/linux/netdev.h
>    Size: 2307      	Blocks: 8          IO Block: 4096   regular file
>  Access: 2023-10-27 15:22:41.520114221 -0700
>  Modify: 2023-10-27 15:22:18.417968446 -0700
>  Change: 2023-10-27 15:22:18.417968446 -0700
>   Birth: 2023-10-27 15:19:45.088000894 -0700
>
>  $ ./tools/net/ynl/ynl-regen.sh -f
>  [...]
>
>  $ stat include/uapi/linux/netdev.h
>    File: include/uapi/linux/netdev.h
>    Size: 2307      	Blocks: 8          IO Block: 4096   regular file
>  Access: 2023-10-27 15:22:41.520114221 -0700
>  Modify: 2023-10-27 15:22:18.417968446 -0700
>  Change: 2023-10-27 15:22:18.417968446 -0700
>   Birth: 2023-10-27 15:19:45.088000894 -0700
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

