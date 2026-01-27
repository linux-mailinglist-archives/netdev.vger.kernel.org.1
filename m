Return-Path: <netdev+bounces-254016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGIjE507eWkmwAEAu9opvQ
	(envelope-from <netdev+bounces-254016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:26:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E439B04F
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ED4130440A4
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA89635EDB6;
	Tue, 27 Jan 2026 22:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TigyRkkx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4334335CBA5
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 22:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769552714; cv=none; b=eQyGWufIBksxgYD3qqeZpVmz59c8Ey7FxuF15PYyjPnVm5KM74u5nkUchsQybGEmDDSIxbZH6ulhe7ssbot0YIZFOIhNGgQPB51hvnCbdf3VVx5UWX1ytLOn0iAGFguDJudqbvp2G0C/ealYROObAvYNL7jJ+NU/tT2cqFK0ews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769552714; c=relaxed/simple;
	bh=KRUwvuwF/PM7ITLfpmVaWQqykACx8OV/i8XDHgots7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3HB0nXAz8+oFL8NicweQxht2qmhl3jtr8ktDUhCyngPtGdJbDuQffhsMfiCf9MPXYyznZFzIR05EkPQjYcJpCN4ICay7GF0jrk/9nwWeqzew/3R7uXylGRwjZmX0n9XSNN5TfsKit/0i0i/gajUiOyFsVV/4UqqkCMrgsSICTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TigyRkkx; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43590a7115aso20492f8f.0
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 14:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769552712; x=1770157512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsTo4cAUvZp8jxGLFOJ3NaCEJaN65doECV0+BSV0gis=;
        b=TigyRkkxMV3hdbFSEVgbTG2m4CeA9EDIHe4O1galSIl+PfkDy9P1zcFB4jGVY0E0vI
         1SOY2WKbiaTb+7nFYxAbmko5C+6JIybI9BgZDQOCBaExYnI3a/NzfeXIinzZI65+mXwj
         MQ2V17zFKNuIVaVuc/M+KD8lG8tpeyY6dNklAqO8c9FvIcGt0EyXLVEUALeGaPVKTIBg
         5QouJyOQJ8EARqyFlMnm1CVXCweeTyBakakAaHdU3pktIwTlyAoKsLGNI2SMm/02Yd/q
         YFIv17oHcCvIa0Sfu3VoRviFNFF8e04VYDjpIXXLdtvvS3UvyMRQegNrO2o7oz89QKby
         UtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769552712; x=1770157512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsTo4cAUvZp8jxGLFOJ3NaCEJaN65doECV0+BSV0gis=;
        b=ZQ+lJ3wq589Wh/u7Swh1fuPzK4ypei+bMwNGs4MLnL4xcKWc/CG4vwa3hZxtDYEY1x
         2Is0tzQ9D9y9QZXDkOKaR57br1N0D9h5p+nSVYuYiLxkUbQCToeuRo2RYWDpIQAylLdE
         z2wR3Mlkym8KqYG5p3q0xB/3Csh3Lx+hjyDTL6cOkSO+mFeGohB3HMi+0+LtZhPbiyAh
         yi4ptCHcUGuTPXF/ozO9P8129VeV2JuBncnQvYzUdUyasafH+KNBNIWI3gI6DUoJh3sP
         N7gSeUXkuSNhsT0LPdxMauT6ZBbDv0lz9aywXhYBEaWELA7iwcMqzRk5k0s/EIKA7PjF
         G/Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWl4+W86VcCSxLp2ahkbfyKEm2HzKFPlnYgazoL6EgpwFL9i6IsLvsp2jnc2WBTLNsKRQVMnJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7oOVq6uDOdP+1rnqwx9kL51+vZ4q1OoLbUSnVgfZ4pdWAVpkp
	JIq5wZSCA6I0owr2x2kNzyvydt7UXoMfYpTg9k1nrvU7l3DSTQ8tDe/a
X-Gm-Gg: AZuq6aKoCy+7hcpL9nlXvo10a/AiiUnMEx+zF4TkHA5Yx1svDvDs9UvWooT9h8xdM7Y
	YxNFEsK4ja2CPBxK6Mf9GIiBudeGugWqUwqu7THASN5kOzh5N2jpJ1eYfQUWJ60UzDkv+nqiPWu
	kJq9riFiUcI+rmftlcB7VqHREhNyVuED07XpA7esxwoaLrfwCL3eNEEpbDGSwKiXAKh9rBhQjNA
	bE0RBbWlZiyRokzJnepJ/3YWMDu8PO6JVkXYhD3VZ970oMtKDUrxSSHtpbwPR0DhJqgNFrNCaQq
	7QoW5cls5KO0eTPY+bJuEemwBMq/etoyAE8LCn8EU49cQs8HkAaZtZvY++1ZpNXVIDZQtI+9x2c
	+P/pQYnlJUVM8aPJVqB4aSxBFxVrTGRUR3i1zcLXetEHFI0ruJ9XeUbRo5ZOzfXR1fz6+fH8682
	qAfQ==
X-Received: by 2002:a05:600c:458c:b0:47e:e20e:bbc0 with SMTP id 5b1f17b1804b1-4806e51e61cmr2197605e9.2.1769552711328;
        Tue, 27 Jan 2026 14:25:11 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:6c51:3f46:e918:f0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdebf86sm18712645e9.8.2026.01.27.14.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 14:25:10 -0800 (PST)
Date: Wed, 28 Jan 2026 00:25:08 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: dsa: lantiq,gswip:
 reference common PHY properties
Message-ID: <20260127222508.gvky6smlrmnj3uix@skbuf>
References: <cover.1769519758.git.daniel@makrotopia.org>
 <d9b6212ad5137feeb58b28e9b0784f1084c813df.1769519758.git.daniel@makrotopia.org>
 <20260127132919.xsvapgqc65f44iah@skbuf>
 <aXjGh1nzeAz8TQzH@makrotopia.org>
 <20260127150747.lzlfzhusywluuxhs@skbuf>
 <aXk38o39i62SIq_K@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXk38o39i62SIq_K@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254016-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1E439B04F
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 10:10:58PM +0000, Daniel Golle wrote:
> Taking a step back I noticed that we need to decide this also for
> mt7530.
> 
> commit bde1ae2d52ab ("net: pcs: pcs-mtk-lynxi: pass SGMIISYS OF node to PCS")
> currently doesn't pass any fwnode when creating the LynxI PCS.
> > +               pcs = mtk_pcs_lynxi_create(priv->dev, NULL, regmap,
> > +                                          MT7531_PHYA_CTRL_SIGNAL3);
> 
> However, each PCS does belong to a specific switch port, and it would be
> advantegous and imho consistent to also assign the ports OF node to the
> PCS, this would allow to configure the polarities also on the MT7530
> SerDes ports.

mt753x_phylink_mac_select_pcs() returns either &priv->pcs[dp->index].pcs
for TRGMII or priv->ports[dp->index].sgmii_pcs for the rest.

How would one know (generally speaking) if properties placed in the
ethernet-port node are for the SGMII PCS or for the other one?

