Return-Path: <netdev+bounces-268266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIJVChFguGlbdAEAu9opvQ
	(envelope-from <netdev+bounces-268266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:54:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F9729FEC1
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C591C302850E
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033C73EC2F0;
	Mon, 16 Mar 2026 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c+JSDY+G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE28F34D93C
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690892; cv=none; b=OJ/mTfSC2wZG9IdQPF72p2dQwnOvt0QTeR9wRTiIoX2eW9MPBf8fwGVCrGfvQchtW+UXqHS3HP8iqJebfQgo4tY+7IhKm/IXJtVEEmq7SXaUZ2UobrqpHOMBERXVz8wZpqO88OmC23zqNbN36Mw3aKCsmx5JihYSAN+WD7YDFYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690892; c=relaxed/simple;
	bh=VNC4IJKud+73KOf230kzDqFIXdI6+MPx4jgJ2TcM77I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxMjql17ljva4lRsgM17w9bflMtCELnqUk6aJ5sHOWXZM1mq7namHJ7owZiClc/7S1yqfm1E/hw9YqmpQEGK7ZN3ZkytUP/cMnoNsYJTo9Ru/iXAj7MP/zGqGAbuzNgqiIObcQMVhUVcT3sGjLinSaly31XL/hRw9FnAoGp1Pug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c+JSDY+G; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-35b9ed7a329so844804a91.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 12:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773690891; x=1774295691;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9IDaJ6oXa0HJPHD2SrYVZIn4JOWUZueJBTKzvHn9pvs=;
        b=PjsoUBDzrHxL5S50WqrI67oat9PMi5WosLrYmnANXMNN8bY9h8O+1oESMVXSF6EjTn
         PbI9F1c+PC2Fkqg+paXO7oyDrNVTXfqeUB+y5uXpBvDTBvLuybcb5FRbOTYOi0vBz8zY
         JJxOmIiApfnmQN6Z4ZKQac4tY3gR7VBjxvV7cevsfIt8CuGucwsrMS7XtZzZgUCBTOrP
         Xo2Y4H+38zXYVn/5qVbaFrVt/TB7gIC0fR4y02xf/iMLyDScK8huk1FEtzVSzEIFQZ+L
         mybI6KwgHWw9Cf47FzcJ5EgSfk3/DhgiaTxUyWL/zi6RHbrwjxWlAo0r25TB5pBFd4US
         OQDw==
X-Forwarded-Encrypted: i=1; AJvYcCU9F+o2ZMBx9z2WjqY6G5nZ0XiwlwI+SiHHQjKZ5kkpqAcaQDobExFiBHzMEKE6wAqWUebeBh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwElnyFXF1lxKDgc/9Ij7ntTXdXHzp5xvLa2p4YthQzeLjO+nL3
	zP8Teysy3rLL1R0yKn/g4v78bE97dyXbWXBrlTlYA6yusVIHkniZjrsYR2pSJzPaKqTZ1GfYfxl
	oRxz/UtuD9eijfrduGUbXo19PA4cYYfQjf+OD2TdKhm1gJCm8nCa5lDkVcNKu9+bKSUaJ27ziEX
	jm3Y0IN3SWrlfeld20fr8HriZ7R2sP6CZmRxQ3MAFj6qnDVEwWLf5MW2Me4KQM31XcldLJoVvWJ
	BrbeMEvuFLXZA5H
X-Gm-Gg: ATEYQzwbW6Q5/yuA+StJfNVkBZxvo69EpF7mORDUMeivSSNnTPR0bAW9Xs3tws3dMnO
	QW1ihyFtH2+MaT7kVB59rVvDfFzukuVxJiTQFK8DYL/8maiQmluU2cLEzeWa0jRQTNHEOy3X/Fl
	5kByZV8Ponb3lBWRGPoY6UITMHibrwhHDlI3E7DHTYMZI/KZKMoMxc7xGLRuACZ8c0okqZkS1Pj
	QOQTWsRHEJmgs6TuALPUnieY4Lu3APXD19KP7Y5HP7Bh0+m/rcAZNFGZZmOiGGv6nxgonO0BJQQ
	d6GrUga0BULQTwn6sMA0kSbq8O4O1Z68vDWP+eH+9Z76jjTtCboBZgTb5CaiyvsKAdy4t8mHfaK
	ERMkVW5gqN/yGZQ+TUos3YwV1ycYZKzxptE280asL3zwPjCAC30NtdB2qOF0voT2flUesdij3+N
	dciwboDe365XYY47BA8QtMToe9PcRkH4YsaCUfNGl5G4ZFTT0dgWlLdkyalGBsNw==
X-Received: by 2002:a17:90b:1cc4:b0:35b:9958:4edd with SMTP id 98e67ed59e1d1-35b99585066mr5079528a91.30.1773690891048;
        Mon, 16 Mar 2026 12:54:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35bada5b770sm79952a91.6.2026.03.16.12.54.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2026 12:54:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89c53a0264cso85886486d6.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 12:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773690889; x=1774295689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9IDaJ6oXa0HJPHD2SrYVZIn4JOWUZueJBTKzvHn9pvs=;
        b=c+JSDY+G+pasR42rwu/CmtSsl4A+h7yMkTBlbLrok1p/lvniB0Cu5jDZc1f8RR53YN
         guK+cCgbCWxe+T6QD5UHnwi9vLsegc4IMwUHSv6flWa2Vq/mOhbk4QtsK+uhkY+H9Yzl
         nQycr86WP5bQJw/RQzNcsbrrHKuBuOe9lNruc=
X-Forwarded-Encrypted: i=1; AJvYcCW3waXIWi0DzPrBRhOFnMnYbL+gZve12dfJ5Qt+b9s8mmvhnDB1HZsfZCjk3hheQz8EKpX1uFU=@vger.kernel.org
X-Received: by 2002:a05:6214:2525:b0:89c:53a0:1c97 with SMTP id 6a1803df08f44-89c53a026f8mr63142456d6.11.1773690889534;
        Mon, 16 Mar 2026 12:54:49 -0700 (PDT)
X-Received: by 2002:a05:6214:2525:b0:89c:53a0:1c97 with SMTP id 6a1803df08f44-89c53a026f8mr63141786d6.11.1773690888886;
        Mon, 16 Mar 2026 12:54:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c4c018f5esm37577006d6.45.2026.03.16.12.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 12:54:48 -0700 (PDT)
Message-ID: <997daf22-260b-40c4-a2d6-8c63f59df9a7@broadcom.com>
Date: Mon, 16 Mar 2026 12:54:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bcmgenet: enable EEE TX LPI by default
To: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260303160225.542613-1-nb@tipi-net.de>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260303160225.542613-1-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[tipi-net.de,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-268266-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B4F9729FEC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/3/26 08:02, Nicolai Buchwitz wrote:
> GENET never initializes priv->eee.eee_enabled or
> priv->eee.tx_lpi_enabled to true, so the link-change callback in
> bcmgenet_mac_config() always calls bcmgenet_eee_enable_set() with
> enable=false.  The result is that EEE is negotiated at the PHY level
> but the MAC never enters Low Power Idle, wasting the power savings
> that EEE is designed to provide.
> 
> Users can work around this with 'ethtool --set-eee eth0 eee on tx-lpi
> on tx-timer 250', but the MAC should enable TX LPI out of the box when
> the hardware supports it, consistent with how phylink-managed MACs
> behave (phylink calls phy_support_eee() which sets eee_enabled=true and
> tx_lpi_enabled=true by default).
> 
> Initialize EEE software state during bcmgenet_open() on GENET v2+ so
> that the link-change path activates EEE in hardware once the PHY
> negotiates it.  Use an LPI timer of 250 us, matching the default used
> by other MAC drivers (mvneta, mvpp2).
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

