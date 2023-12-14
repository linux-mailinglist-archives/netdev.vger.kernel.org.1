Return-Path: <netdev+bounces-57478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23B0813251
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14507B21A2A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F9258AA3;
	Thu, 14 Dec 2023 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huaEujNz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31687CF
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:58:21 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d9e9b72ecfso4753180a34.3
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702562300; x=1703167100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UA7DwafJPzZOaznTiBBnxL8sphCdVodoIwfdbjMBu6Q=;
        b=huaEujNzEN1XQTMDSPCn/chau3j71cNU5A4AVwG12mGjLoFGGZU6fg4IqjAh7VN+Tk
         /tTL0DAl6CzMgqdHmMrMWQKFUOim0j8/k2IofgYTlRiFTx30MM5PcI9InIxgAjjqiNdh
         uWozA6Rg77gueREMh1KWmhC9RsroBK7Zyv+efhjLo9xS1pWRGuSqFXMKXfEcfWgQczKv
         fU5IBdPIGepZKrkADhDgJ4qosycnN3s7S4UaRn1qP23pA2LtioXg2L5yHj83RKU7rPZb
         Pj0gau+4ZtouDjt0xDtX5FiWxkwMz9Z6vssndT/1jIrTV0UmEdLRadoMLLVYmmLA5ECV
         Mq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702562300; x=1703167100;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UA7DwafJPzZOaznTiBBnxL8sphCdVodoIwfdbjMBu6Q=;
        b=VgxgspIJJFoLmZxOoGe6YB+Z+OPMGnVOKziKPY8CcABR/aDpj576N+CiZaY9c7gl+H
         c/EEXIm7ka/Ojf/8fkfJIAtTW3I330J2rzNDFGIcsONKmLSF8BBYwkiH6uQ1CpOm1m/8
         6IOyBNpeIx2gpi4U+EpbVY79aEQO0PjIMDVV5TY92mIVbd+UuNzIkM2zBJ3sxdmfk//Q
         OAunw8qxoRqd2jQE23BtlONppW+9XMZOfldMZRwAdvtMAHZD3CkfPWXb4UManYS/lZ4A
         uhO8e0tRspxXj63AH4yssJcx12aQ5Hojq2nfh23+g5iHrovbe0zfKCoZkrmzqEZ0CN1V
         3zig==
X-Gm-Message-State: AOJu0YylIwFDHOHN/bu5B9gNUZz+1VuKELFo2V38PCawFAxM9u7EFRZl
	nU4ZKWiiTVix800sY5mUi1/7lxNgAXo=
X-Google-Smtp-Source: AGHT+IHQ9Gc+a5JvAlzFe6BtVynbdXqUBwUqfmy4rv+TDhHa+m+nQ+LwrWQqCG2EW1kMvP5BpmjGFg==
X-Received: by 2002:a05:6830:140e:b0:6d9:e2ee:3d2b with SMTP id v14-20020a056830140e00b006d9e2ee3d2bmr10128996otp.27.1702562300416;
        Thu, 14 Dec 2023 05:58:20 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id z23-20020ac87117000000b00423de58d3d8sm5764563qto.40.2023.12.14.05.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:58:19 -0800 (PST)
Date: Thu, 14 Dec 2023 08:58:19 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Chao Wu <wwchao@google.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <657b09fb92264_14c73d294c9@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231214104901.1318423-4-edumazet@google.com>
References: <20231214104901.1318423-1-edumazet@google.com>
 <20231214104901.1318423-4-edumazet@google.com>
Subject: Re: [PATCH net-next 3/3] selftests/net: optmem_max became per netns
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> /proc/sys/net/core/optmem_max is now per netns, change two tests
> that were saving/changing/restoring its value on the parent netns.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

