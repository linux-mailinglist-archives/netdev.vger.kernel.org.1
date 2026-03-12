Return-Path: <netdev+bounces-267200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENJbNf4cs2mDSAAAu9opvQ
	(envelope-from <netdev+bounces-267200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:07:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ADD2787F0
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43C393042757
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C2A402B90;
	Thu, 12 Mar 2026 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q2dicZ3S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BF740242D
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346033; cv=none; b=Si6N8ogVvONZtlEP/uUv8uPJbEGh2nGP2pApiM11RUs7X8mxBXhIWbG4XsygxYKKZ9c2k4F15LBGSYLLkyLW68Sd4hvZ3DGyXXUrMV4oO3xM0QreKageWK3IMxcsbouybF4wHullEa1hxI3q9ktYV+458IMLYvB0d4tKEKq9M10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346033; c=relaxed/simple;
	bh=mkPn6azSc5sBdNjIBFEPFL6chM6v748TKJtFgSgI6eQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=LfXSo3QzL691zGln1/n3ekuYcF6om0A/6KeJTffwppo3BTDG4L9YKUi7rkajUnmb3wkNQNbs3Mo1KoOFRE3P/c2I5VYL7X2XA+KEpTndskMcvvtqbwaQViARrskXLNMx+y/2FLf+tmTYt8dS79SFktPKU+ECUNGChMG/kMtPoNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=q2dicZ3S; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-41708f6c3feso935478fac.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773346030; x=1773950830; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pWby7tRTaFMLCxNO3vkJZ08S+rk6Df/iLShGmtlipk=;
        b=q2dicZ3SnpIS4khOQpYl6JJsTkgwF/v8Tiyv5QrQWYES0Hp/od780CRaSel44Bpdd9
         onKCoW/cyjl2cTrmfxnM/u8aEdTRWd7BrEe+uwxclSzBjHa+Av4bgrv9Lb0ezEQnBmom
         QHQcouCrZgi9/OBimwLnWzyHUZ3juoVdN8myQKbqsNNa8+PPE5bO3/mKR+UQfQKqpVHx
         rAdEHvXZINikjEUqVQFQgsKHxt1HaXUNDDEXAs3lQx9JHBvEPfaEhY7X0Xg+SV/sDnGc
         eLg0jTbANl7prlenWHxeaSCBXxnSEG/qF5+/GkkQyk+nDQBlw2t4G0pJz8FTfzjM3K9P
         ZVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773346030; x=1773950830;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2pWby7tRTaFMLCxNO3vkJZ08S+rk6Df/iLShGmtlipk=;
        b=prIxg2llkm5GOrlgxZrIlYfaFCV8Bx88VOOSLfFLQmBOzOMA/JdhGJgASFgEiXrLGW
         Yx1DLwa9hdRSjN1rXTUVq08zEjOXjjlet38sz6LxL+3BP32rMOKsTFEnvEfj9bjPX5ug
         KR80vWSczW2hHU6Dam39E0CbHuVhiw7I5vzi8YxgPRzsnOpLUVfnTD5hUluLeXt3LfZx
         WNCAddH82Y9h1DG072klJLCm3floa5xspVfAUVHWO0TIAzL5OhHeqgxdttE50X6k3oCV
         P3g/svKNMGVw13gv9gzEqlrRlGJHmI0pwit9n8769t5nXUp8pBRbm3yiGpHHE8YZdYa0
         ReOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXObdp0ApYeOZSvEzI6JNCpN+GpdW9M4v+VCO0QlLjO5VaVKPj2bVWNOj2oWzF2ZFRlC4HCH/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcbCnBc9uaSxDXLN9ORnPESzOHh46969+y4o47fMYtTXd/Naqb
	w8iNNUagCoI2ifnA1hWI4jCFCY979xoFziGZw8AjzBH1aDdcNmzGTcZjG06oGNumsec=
X-Gm-Gg: ATEYQzxXQlFcVIQGKbc09M3IxpaCteN8XWrIqCcyYWUHar8nzarpkXrXMpDm+ufiNex
	UHjur+D2UzpqmDoOFvgYxQwOIBAHPikqOMqxauaIFLXzskzOIAVL7OxudWb432nj4JTEXTrLgvC
	0e3i7kSwy8KxJ46rVDhcSjPtWzsklVyghD33hyvzjq8ko3HY1Qdff49Q3jz98+QARH+ZdU5KqZQ
	PDbusZOaLBs9J4C3b1UHufOVbNBe45NFSEo2OhPLO9zeQuBiLocpAe0TcHV0Bkwe+Ic7cpMNHRJ
	x36/4DAbaCL/9BYfSb8v4oS/uxzbQko8KwMzJX1o1lVL5ZspyON0l0MqIeYkFHeoGuzE5cMOiA+
	9jgJlu1xPid5eOlKp6SRoxj/apsyes0QZ6hFsv+l4MeoBg8APkkSlcbVHcGXKW4zEcXXEjWmbUZ
	qNpRFJHY+J+HxPRAOeJ4Tr3oiZyh2b
X-Received: by 2002:a05:6870:a796:b0:3e8:8b6f:9d85 with SMTP id 586e51a60fabf-417b937d46cmr332682fac.29.1773346030308;
        Thu, 12 Mar 2026 13:07:10 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1f95:f82e:8747:8137])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6c7885sm5600081fac.17.2026.03.12.13.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 13:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 03/18] clk: mediatek: Add MT8189 apmixedsys clock
 support
From: David Lechner <dlechner@baylibre.com>
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, 
 Miles Chen <miles.chen@mediatek.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, Project_Global_Chrome_Upstream_Group@mediatek.com, 
 Qiqi Wang <qiqi.wang@mediatek.com>, sirius.wang@mediatek.com, 
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
In-Reply-To: <20260309120512.3624804-4-irving-ch.lin@mediatek.com>
References: <20260309120512.3624804-1-irving-ch.lin@mediatek.com>
 <20260309120512.3624804-4-irving-ch.lin@mediatek.com>
Date: Thu, 12 Mar 2026 15:06:36 -0500
Message-Id: <177334599652.4124794.495599695131479130@freyr>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=mkPn6azSc5sBdNjIBFEPFL6chM6v748TKJtFgSgI6eQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpsxzdMiMJbTxqXDno8lz7uKeJqq/XgEtUTcoAy
 ZhkKwBwxnOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabMc3QAKCRDCzCAB/wGP
 wFqcB/48FpvKpV3InEamRZjYBZWJ6fLi/SAwUkbGJyUmItM/vnWwftYkuxXm1sC369JhkJ6LTZ6
 YfgivaaIA/87e8AwAr90CJKmSjB91XqNMT4+0k8RYkN+77VvJcZ2apyV/geYv8E1R7u7nT8gr0m
 fsxRyDy7ZrMFdpc8ENod3K9Tt/ord3fYSSeyUQBCbbZUha8Gsrh4ptu2rpCErKtQ6Vigzdjiw1z
 o+eTFnGlkzvD7rcJLxm1Qp8UAeRgvqtYIFmydhZNYocG71l1fIEkKe+XDpvnBMkYyj3dW1+mP+Z
 1SKiymojf8wZ+PdFx4HI3agvkAyfo/sl9yqVkSAZvBJAm859
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267200-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,collabora.com,chromium.org,mediatek.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: 42ADD2787F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 09 Mar 2026 20:04:45 +0800, irving.ch.lin <irving-ch.lin@mediatek.com> wrote:
> Add support for the MT8189 apmixedsys clock controller, which provides
> PLLs generated from SoC 26m.
> 

...

> +static int clk_mt8189_apmixed_probe(struct platform_device *pdev)
> +{
> +	int r;
> +	struct clk_hw_onecell_data *clk_data;
> +	struct device_node *node = pdev->dev.of_node;
> +	const u8 *fhctl_node = "mediatek,mt8189-fhctl";
> +
> +	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(apmixed_plls));
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
> +
> +	r = mtk_clk_register_pllfhs(&pdev->dev, apmixed_plls, ARRAY_SIZE(apmixed_plls),
> +				    pllfhs, ARRAY_SIZE(pllfhs), clk_data);
> +	if (r)
> +		goto free_apmixed_data;
> +
> +	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +	if (r)
> +		goto unregister_plls;
> +
> +	platform_set_drvdata(pdev, clk_data);
> +
> +	return 0;
> +
> +unregister_plls:
> +	mtk_clk_unregister_plls(apmixed_plls, ARRAY_SIZE(apmixed_plls),

Should this be mtk_clk_unregister_pllfhs()?

> +				clk_data);
> +free_apmixed_data:
> +	mtk_free_clk_data(clk_data);
> +	return r;
> +}
> +
> +static void clk_mt8189_apmixed_remove(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
> +
> +	of_clk_del_provider(node);
> +	mtk_clk_unregister_pllfhs(apmixed_plls, ARRAY_SIZE(apmixed_plls), pllfhs,
> +				  ARRAY_SIZE(pllfhs), clk_data);
> +	mtk_free_clk_data(clk_data);
> +}
> +

-- 
David Lechner <dlechner@baylibre.com>

