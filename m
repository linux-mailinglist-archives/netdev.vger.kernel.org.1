Return-Path: <netdev+bounces-63552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCEC82DE3A
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 18:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CEBF1F22736
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 17:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1A317C6E;
	Mon, 15 Jan 2024 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="achoYRON"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A611718021
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bb53e20a43so6261023b6e.1
        for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 09:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1705338712; x=1705943512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1r0NmWkbIKKROfhsCYDqekqsajlDfIpHdNNTOemmGZ0=;
        b=achoYRONR2Ndy9nEhCJMCU65zJ4gEqxEl66c1jr96OqveCsgUXG+nGPVe9ytj5UF45
         DRLUMRJQ1cnGkRzttC+/PrJK2Ia58tdtU0m55sVF/QjsnejHvigVKyrLPot7+YIYseeF
         U55TEaiDlNyei0bki/56EUQ8Ux2I4PrUwZv+DRaf25rWbKO3Awc1qddmZenLvkPGvR9B
         EAgDG3g6599b5qcBFJ0gWB2Aw8i0kxiWcAwsXwzsOLNUVF7xDrsoFsIJQXYs87F0TjcL
         TtqjpkxYTPweVkbnsEFG51gNhrxMAn3WoSVdhQ3JipjON1hrJv0bdhGyfdQAi/nywa5G
         G0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705338712; x=1705943512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1r0NmWkbIKKROfhsCYDqekqsajlDfIpHdNNTOemmGZ0=;
        b=CWI53MVY3pcMGsLnWOGWRK8dPYGYYTEdKksUiR3qmyiiNq+UR2ioo5C5H6cLJ6Z7v6
         +0qLVqRdmAnp4ftaodLWtikB6u/wwtUANIKIeUmeK4RNnoSxAr/+3QBYMcfOXrLD3266
         TcSfaPfKQhwnuJ8SPyb3wxvFUeVGlQml86CnBkiKPwaXiImbaRgdSvukgl4Ud2rj75Fk
         vckkCyQHK+p63CZ1wdmPIjvIMHFyt6UUU90wih6jxS6U0TO/w1Src7Tz3MGWM0MJ8Gbz
         G25WoH8NUC7j9Vu/KbKQ3BgkizyqS6dTgnKt3ZGAfKrXuaoG5Q0SHDmaD2Ysj5rbLtke
         xJnw==
X-Gm-Message-State: AOJu0YwaNM8SSdlfXruMsELB5SGnjBLxkRYUL2q3ssKy6z4KMtF70vo2
	HWbxAOJsZXnN9U+PCxv+n24g7Y73fumgEQ==
X-Google-Smtp-Source: AGHT+IH7fDfmTrit8K16Up5KuFHyjDfhQqvVvbdWXY/d5BgoCeeSmS8QeeqIHVeOnKrEyt69gl+3Qw==
X-Received: by 2002:a05:6358:5398:b0:175:b906:8c87 with SMTP id z24-20020a056358539800b00175b9068c87mr4529168rwe.21.1705338711560;
        Mon, 15 Jan 2024 09:11:51 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id o16-20020a056a00215000b006d9abe929desm7795026pfk.67.2024.01.15.09.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 09:11:51 -0800 (PST)
Date: Mon, 15 Jan 2024 09:11:49 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Quentin Deslandes <qde@naccy.de>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>, Martin KaFai
 Lau <martin.lau@kernel.org>, kernel-team@meta.com
Subject: Re: [RFC iproute2 v5 2/3] ss: pretty-print BPF socket-local storage
Message-ID: <20240115091149.26375067@hermes.local>
In-Reply-To: <20240115164605.377690-3-qde@naccy.de>
References: <20240115164605.377690-1-qde@naccy.de>
	<20240115164605.377690-3-qde@naccy.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jan 2024 17:46:04 +0100
Quentin Deslandes <qde@naccy.de> wrote:

> +	if (oneline && bpf_map_opts_is_enabled()) {
> +		fprintf(stderr, "ss: --oneline, --bpf-maps, and --bpf-map-id are incompatible\n");
> +		exit(-1);
> +	}
> +

You could figure out hot to make --oneline work

